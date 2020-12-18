import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

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
  final Function(ServerData data, String topic) onDeviceDataReceivedCallback;

  MQTTClientWrapper(
      this.onConnectedCallback, this.onDeviceDataReceivedCallback);
  final _mqttStreamController = StreamController<dynamic>.broadcast();
  Function(ServerData) get mqttSink => _mqttStreamController.sink.add;

  Stream<dynamic> get mqttStream => _mqttStreamController.stream;
  void disposeStreams() {
    _mqttStreamController?.close();
  }

  Future prepareMqttClient() async {
    _setupMqttClient();
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

  void _setupMqttClient() {
    String _id = Random(300).nextInt(300).toDouble().toString();
    print('MQTTClientWrapper::Connecting with id systemApp/$_id');
    client = MqttClient.withPort(
        Constants.serverUri, 'systemApp/$_id', Constants.mqttPort);
    client.logging(on: false);
    client.keepAlivePeriod = 60;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;
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

  void _preData(serverDataJson, topicName) {
    if ((serverDataJson["STATUS"] == "LOGIN") ||
        (serverDataJson["STATUS"] == "INVALID")) {
      publishData(Constants.credentials, 'APP/CREDENTIALS');
      return;
    } else {
      if (serverDataJson["TOKEN"] != null) {
        ServerData decodedData = ServerData.fromJson(serverDataJson);
        if (decodedData != null)
          onDeviceDataReceivedCallback(decodedData, topicName);
        return;
      } else if (serverDataJson["MUSIC"] != null) {
        ServerData decodedData = ServerData.fromJson(serverDataJson);
        print(decodedData.songs.items);
        if (decodedData != null)
          onDeviceDataReceivedCallback(decodedData, topicName);
        return;
      } else if (serverDataJson["MUSIC"] != null) {
        ServerData decodedData = ServerData.fromJson(serverDataJson);
        print(decodedData.songs.items);
        if (decodedData != null)
          onDeviceDataReceivedCallback(decodedData, topicName);
        return;
      } else if (serverDataJson["ROOMS"]!=null) {
        ServerData decodedData = ServerData.fromJson(serverDataJson);
        print(decodedData.rooms.items);
        if (decodedData != null)
          onDeviceDataReceivedCallback(decodedData, topicName);
        return;
      } else if (serverDataJson["TAG"] != null) {
        ServerData decodedData = ServerData.fromJson(serverDataJson);
        print(decodedData.tag);
        if (decodedData != null)
          onDeviceDataReceivedCallback(decodedData, topicName);
      } else if (serverDataJson["STATUS"] == 'FAILURE') {
        ServerData decodedData = ServerData.fromJson(serverDataJson);
        print(decodedData.status);
        if (decodedData != null)
          onDeviceDataReceivedCallback(decodedData, topicName);
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

  void _onDisconnected() {
    print(
        'MQTTClientWrapper::OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus.returnCode == MqttConnectReturnCode.solicited) {
      print(
          'MQTTClientWrapper::OnDisconnected callback is solicited, this is correct');
    }
    connectionState = MqttCurrentConnectionState.DISCONNECTED;
    ServerDataBloc()
        .serverConnect('SERVER/AUTHORIZE', 'SERVER/RESPONSE', 'REGISTER/INFO');
  }

  void _onConnected() {
    connectionState = MqttCurrentConnectionState.CONNECTED;
    print(
        'MQTTClientWrapper::OnConnected client callback - Client connection was sucessful');
    onConnectedCallback();
  }
}
