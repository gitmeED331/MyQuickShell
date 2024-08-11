import "../../"
import "../../icons/"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire

RowLayout {
    id: root

    // required property PwNode node
    property string currDate

    spacing: 10
    anchors.bottom: parent.bottom

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSource, Pipewire.defaultAudioSink, node]
    }

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

    //Audio
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
            spacing: 20

            RowLayout {
                id: input

                Text {
                    text: ""
                    font.family: Cfg.font
                    font.pixelSize: 20
                    color: Cfg.colors.color1
                }

                Text {
                    text: Pipewire.defaultAudioSource !== null ? `${Math.floor(Pipewire.defaultAudioSource.audio.volume * 100)}%` : "100%"
                    font.family: Cfg.font
                    font.pixelSize: 20
                    color: Cfg.colors.color1

                    MouseArea {
                        anchors.fill: parent
                        onWheel: (event) => {
                            if (event.angleDelta.y > 0)
                                Pipewire.defaultAudioSource.audio.volume += 0.01;
                            else
                                Pipewire.defaultAudioSource.audio.volume -= 0.01;
                        }
                    }

                }

            }

            RowLayout {
                id: output

                // Text {
                //     text: ""
                //     font.family: Cfg.font
                //     font.pixelSize: 20
                //     color: "white"
                // }
                property string speakerIcon: Quickshell.iconPath(Icons.speaker.muted)

                function speakerIcon() {
                    if (Pipewire.defaultAudioSink !== null) {
                        if (Pipewire.defaultAudioSink.audio.muted)
                            return Quickshell.iconPath(Icons.speaker.muted);
                        else if (Pipewire.defaultAudioSink.audio.volume < 0.3)
                            return Quickshell.iconPath(Icons.speaker.low);
                        else if (Pipewire.defaultAudioSink.audio.volume > 0.3 && Pipewire.defaultAudioSink.audio.volume < 0.6)
                            return Quickshell.iconPath(Icons.speaker.medium);
                        else if (Pipewire.defaultAudioSink.audio.volume > 0.6 && Pipewire.defaultAudioSink.audio.volume < 0.9)
                            return Quickshell.iconPath(Icons.speaker.high);
                        else if (Pipewire.defaultAudioSink.audio.volume > 1)
                            return Quickshell.iconPath(Icons.speaker.overamplified);
                    }
                    return null;
                }

                Image {
                    source: speakerIcon()
                    width: 20
                    height: 20
                    visible: true
                }

                Text {
                    text: Pipewire.defaultAudioSink !== null ? `${Math.floor(Pipewire.defaultAudioSink.audio.volume * 100)}%` : "null"
                    font.family: Cfg.font
                    font.pixelSize: 15
                    color: Cfg.colors.color1

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            audioMixerPopup.item.targetVisible = !audioMixerPopup.item.targetVisible;
                        }
                        onWheel: (event) => {
                            if (event.angleDelta.y > 0)
                                Pipewire.defaultAudioSink.audio.volume += 0.03;
                            else
                                Pipewire.defaultAudioSink.audio.volume -= 0.03;
                        }
                    }

                }

            }

        }

    }

    Rectangle {
        property bool isHovered: false

        Layout.preferredWidth: isHovered ? battery.width + internet.width + timeDate.width + 10 * 2 : 145
        height: panel.exclusiveZone - 5
        radius: 50
        Layout.alignment: Qt.AlignRight
        color: Cfg.colors.mainBG
        clip: true

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

        border {
            color: Cfg.colors.border
            width: 1.5
        }

        RowLayout {
            spacing: 10

            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
                leftMargin: 10
            }

            Image {
                id: battery

                sourceSize.width: 35
                sourceSize.height: 35
                source: "../../icons/battery.svg"
            }

            Image {
                id: internet

                sourceSize.width: parent.height - 10
                sourceSize.height: parent.height - 10
                source: "../../icons/ethernet.svg"
            }

            Text {
                id: timeDate

                text: root.currDate
                font.family: Cfg.font
                font.pixelSize: 15
                font.bold: true
                color: Cfg.colors.color1
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
