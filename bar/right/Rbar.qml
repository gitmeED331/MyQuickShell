import "../../"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire

RowLayout {
    //Audio
    //required property PwNode node

    id: root

    property string currDate

    spacing: 10
    anchors.bottom: parent.bottom

    SystemClock {
        id: clock

        property string hour: hours
        property string minute: minutes

        function getDate() {
            let today = new Date();
            let dd = String(today.getDate()).padStart(2, '0');
            let mm = String(today.getMonth() + 1).padStart(2, '0');
            let yyyy = today.getFullYear();
            let currHour = clock.hour.padStart(2, '0');
            let currMinute = clock.minute.padStart(2, '0');
            root.currDate = `${currHour}:${currMinute} ${dd}.${mm}.${yyyy}`;
        }

        Component.onCompleted: {
            getDate();
        }
        onMinutesChanged: {
            getDate();
        }
    }

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

    Rectangle {
        property bool isHovered: false

        Layout.preferredWidth: isHovered ? battery.width + internet.width + timeDate.width + 10 * 4 : 125
        height: panel.exclusiveZone - 5
        border.color: Cfg.colors.border
        border.width: 1.5
        radius: 10
        Layout.alignment: Qt.AlignCenter
        color: Cfg.colors.mainBG
        clip: true

        RowLayout {
            spacing: 10

            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                leftMargin: 10
            }

            Image {
                id: battery

                sourceSize.width: 20
                sourceSize.height: 20
                source: "../../icons/battery.svg"
            }

            Image {
                id: internet

                sourceSize.width: 20
                sourceSize.height: 20
                source: "../../icons/ethernet.svg"
            }

            Text {
                id: timeDate

                text: root.currDate
                font.family: Cfg.font
                font.pixelSize: 15
                color: "white"
            }

        }

        MouseArea {
            id: mouse

            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                parent.isHovered = true;
            }
            onExited: {
                parent.isHovered = false;
            }
        }

        Behavior on Layout.preferredWidth {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutQuad
            }

        }

    }

}
