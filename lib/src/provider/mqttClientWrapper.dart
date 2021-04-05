import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_mac/get_mac.dart';

import 'package:systemAPP/constants.dart' as Constants;

import 'package:mqtt_client/mqtt_client.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';

import 'package:systemAPP/src/models/mqtt_models.dart';
import 'package:systemAPP/src/models/serverData_model.dart';

class MQTTClientWrapper {
  MqttClient client;
  // LocationToJsonConverter locationToJsonConverter = LocationToJsonConverter();
  // JsonToLocationConverter jsonToLocationConverter = JsonToLocationConverter();

  MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.IDLE;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;

  final VoidCallback onConnectedCallback;
  final Function(ServerData data, String topic, String dataType)
      onDeviceDataReceivedCallback;

  MQTTClientWrapper(
      this.onConnectedCallback, this.onDeviceDataReceivedCallback);
  final _mqttStreamController = StreamController<dynamic>.broadcast();
  Function(ServerData) get mqttSink => _mqttStreamController.sink.add;

  Stream<dynamic> get mqttStream => _mqttStreamController.stream;
  void disposeStreams() {
    _mqttStreamController?.close();
  }

  Future prepareMqttClient() async {
    await _setupMqttClient();
    await _connectClient();
  }

  bool publishData(String data, String topico) {
    _publishMessage(data, topico);
    return true;
  }

  Future<void> _connectClient() async {
    try {
      print('MQTTClientWrapper::Mosquitto client connecting....');
      connectionState = MqttCurrentConnectionState.CONNECTING;
      await client.connect();
    } on Exception catch (e) {
      print('MQTTClientWrapper::client exception - $e');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }

    if (client.connectionStatus.state == MqttConnectionState.connected) {
      connectionState = MqttCurrentConnectionState.CONNECTED;
      print('MQTTClientWrapper::MQTT client connected');
    } else {
      print(
          'MQTTClientWrapper::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }
  }

  Future<String> _setupMqttClient() async {
    String _id = await GetMac.macAddress;

    print('MQTTClientWrapper::Connecting with id systemApp/$_id');
    client =
        MqttClient.withPort(Constants.serverUri, 'sA/$_id', Constants.mqttPort);
    client.logging(on: false);
    client.keepAlivePeriod = 60;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;
    return _id;
  }

  void subscribeToTopic(String topicName) {
    print('MQTTClientWrapper::Subscribing to the $topicName topic');
    client.subscribe(topicName, MqttQos.atMostOnce);

    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload;
      final String serverDataJsonString =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      //final decodedData = json.decode(resp.body.toString());
      // if()

      final serverDataJson = json.decode(serverDataJsonString);
      print("MQTTClientWrapper::GOT A NEW MESSAGE $serverDataJsonString");
      _preData(serverDataJson, topicName);
    });
  }

  void _preData(serverDataJson, topicName) async {
    if ((serverDataJson["STATUS"] == "LOGIN") ||
        (serverDataJson["STATUS"] == "INVALID")) {
      publishData(Constants.credentials, 'APP/CREDENTIALS');
      await Future.delayed(Duration(seconds: 2));
      return;
    } else {
      if (serverDataJson["TOKEN"] != null) {
        ServerData decodedData = ServerData.fromJson(serverDataJson);
        if (decodedData != null)
          onDeviceDataReceivedCallback(decodedData, topicName, 'TOKEN');
        return;
      } else if (serverDataJson["MUSIC"] != null) {
        ServerData decodedData = ServerData.fromJson(serverDataJson);
        print('music');
        print(decodedData.songs.items);
        if (decodedData != null)
          onDeviceDataReceivedCallback(decodedData, topicName, 'MUSIC');
        return;
      } else if (serverDataJson["DEVICES"] != null) {
        ServerData decodedData = ServerData.fromJson(serverDataJson);
        print('DEVICES');
        print(decodedData.devices.items);
        if (decodedData != null)
          onDeviceDataReceivedCallback(decodedData, topicName, 'DEVICES');
        return;
      } else if (serverDataJson["ROOMS"] != null) {
        ServerData decodedData = ServerData.fromJson(serverDataJson);
        print('Rooms');
        print(decodedData.rooms.items);
        if (decodedData != null)
          onDeviceDataReceivedCallback(decodedData, topicName, 'ROOMS');
        return;
      } else if (serverDataJson["PLAYLISTS"] != null) {
        ServerData decodedData = ServerData.fromJson(serverDataJson);
        print('PLAYLISTS');
        print(decodedData.rooms.items);
        if (decodedData != null)
          onDeviceDataReceivedCallback(decodedData, topicName, 'PLAYLISTS');
        return;
      } else if (serverDataJson["PTX"] != null) {
        ServerData decodedData = ServerData.fromJson(serverDataJson);
        print('PTX');
        print(decodedData.rooms.items);
        if (decodedData != null)
          onDeviceDataReceivedCallback(decodedData, topicName, 'PTX');
        return;
      } else if (serverDataJson["TAG"] != null) {
        ServerData decodedData = ServerData.fromJson(serverDataJson);
        print('tag');
        print(decodedData.tag);
        if (decodedData != null)
          onDeviceDataReceivedCallback(decodedData, topicName, 'TAG');
      } else if (serverDataJson["TAGS"] != null) {
        ServerData decodedData = ServerData.fromJson(serverDataJson);
        print('tags');
        print(decodedData.tags);
        if (decodedData != null)
          onDeviceDataReceivedCallback(decodedData, topicName, 'TAGS');
      } else if (serverDataJson["STATUS"] == 'FAILURE') {
        ServerData decodedData = ServerData.fromJson(serverDataJson);
        print("failure");
        print(decodedData.status);
        if (decodedData != null)
          onDeviceDataReceivedCallback(decodedData, topicName, 'FAILURE');
      } else if (serverDataJson["STATUS"] == 'SUCCESS') {
        ServerData decodedData = ServerData.fromJson(serverDataJson);
        print("succes wraper");
        print(decodedData.status);
        if (decodedData != null)
          onDeviceDataReceivedCallback(decodedData, topicName, 'SUCCESS');
      }
    }
  }

  void _publishMessage(String message, String topicO) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);

    print('MQTTClientWrapper::Publishing message $message to topic $topicO');
    client.publishMessage(topicO, MqttQos.exactlyOnce, builder.payload);
  }

  void _onSubscribed(String topic) {
    print('MQTTClientWrapper::Subscription confirmed for topic $topic');
    subscriptionState = MqttSubscriptionState.SUBSCRIBED;
    if (topic == 'SERVER/RESPONSE') {
      ServerDataBloc().login();
    }
  }

  void _onDisconnected() async {
    print(
        'MQTTClientWrapper::OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus.returnCode == MqttConnectReturnCode.solicited) {
      print(
          'MQTTClientWrapper::OnDisconnected callback is solicited, this is correct');
    }
    connectionState = MqttCurrentConnectionState.DISCONNECTED;
    // ServerDataBloc()
    //     .serverConnect('SERVER/AUTHORIZE', 'SERVER/RESPONSE', 'REGISTER/INFO');
    // await Future.delayed(Duration(seconds: 2));
  }

  void _onConnected() {
    connectionState = MqttCurrentConnectionState.CONNECTED;
    print(
        'MQTTClientWrapper::OnConnected client callback - Client connection was sucessful');
    onConnectedCallback();
  }
}
