import "../../"
import "../../icons/"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire

required property PwNode node
  PwObjectTracker {
        objects: [Pipewire.defaultAudioSource, Pipewire.defaultAudioSink, node]
    }
    PwNodeLinkTracker {

                    node: Pipewire.defaultAudioSink
                }
Rectangle {
        width: 200
        height: panel.exclusiveZone - 5
        Layout.alignment: Qt.AlignLeft
        color: Cfg.colors.mainBG
        clip: true
        radius: 30

        border {
            color: Cfg.colors.border
            width: 1.5
        }

        RowLayout {
            anchors.centerIn: parent
            anchors.fill: parent
            spacing: 20

            RowLayout {
                id: input

                Text {
                    text: ""
                    font.family: Cfg.font
                    font.pixelSize: 15
                    color: Cfg.colors.color1
                }

                Text {
                    text: Pipewire.defaultAudioSource !== null ? `${Math.floor(Pipewire.defaultAudioSource.audio.volume * 100)}%` : "100%"
                    font.family: Cfg.font
                    font.pixelSize: 15
                    color: Cfg.colors.color1

                    MouseArea {
                        anchors.fill: parent
                        onWheel: (event) => {
                            if (event.angleDelta.y > 0)
                                Pipewire.defaultAudioSource.audio.volume += 0.05;
                            else
                                Pipewire.defaultAudioSource.audio.volume -= 0.05;
                        }
                    }

                }

            }

            RowLayout {
                // Text {
                //     text: ""
                //     font.family: Cfg.font
                //     font.pixelSize: 20
                //     color: "white"
                // }

                id: output

                Rectangle {
                    function speakerIcon() {
                        if (Pipewire.defaultAudioSink !== null) {
                            if (Pipewire.defaultAudioSink.audio === muted)
                                return Icons.speaker.muted;

                            if (Pipewire.defaultAudioSink.audio.volume < 0.3)
                                return Icons.speaker.low;

                            if (Pipewire.defaultAudioSink.audio.volume > 0.3 && Pipewire.defaultAudioSink.audio.volume < 0.6)
                                return Icons.speaker.medium;

                            if (Pipewire.defaultAudioSink.audio.volume > 0.6 && Pipewire.defaultAudioSink.audio.volume < 0.9)
                                return Icons.speaker.high;

                            if (Pipewire.defaultAudioSink.audio.volume > 1)
                                return Icons.speaker.overamplified;

                        }
                    }

                    Layout.alignment: Qt.AlignCenter
                    width: 60
                    height: 20
                    color: Cfg.colors.mainBG
                    clip: true
                    radius: 30

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            audioMixerPopup.item.mixerTargetVisible = !audioMixerPopup.item.mixerTargetVisible;
                        }
                        onWheel: (event) => {
                            if (event.angleDelta.y > 0)
                                Pipewire.defaultAudioSink.audio.volume += 0.05;
                            else
                                Pipewire.defaultAudioSink.audio.volume -= 0.05;
                        }
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.centerIn: parent

                        Rectangle {
                            width: 20
                            height: 20
                            color: "red"

                            Image {
                                id: volumeIcon

                                source: Quickshell.iconPath(print(speakerIcon()))
                                sourceSize.width: 20
                                sourceSize.height: 20
                                fillMode: Image.PreserveAspectFit
                                visible: true
                            }

                        }

                        Text {
                            text: Pipewire.defaultAudioSink !== null ? `${Math.floor(Pipewire.defaultAudioSink.audio.volume * 100)}%` : "null"
                            font.family: Cfg.font
                            font.pixelSize: 15
                            color: Cfg.colors.color1
                        }

                    }

                }

            }

        }

    }