import "../../"
import "../../functions/"
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.services.Mpris

PopupWindow {
    property bool targetVisible: false

    onTargetVisibleChanged: {
        if (targetVisible) {
            visible = true;
            mediaInterface.y = 0;
        } else {
            mediaInterface.opacity = 0;
        }
    }
    //visible: targetVisible
    anchor.rect.x: panel.width / 2 - width / 2
    anchor.rect.y: panel.exclusiveZone + 15
    anchor.window: panel
    width: 500
    height: 150
    color: "transparent"

    Rectangle {
        //        property int spacing: 40

        id: mediaInterface

        radius: 50
        onOpacityChanged: {
            if (opacity == 0) {
                mediaPopup.active = false;
                mediaPopup.loading = true;
            }
        }
        width: parent.width - 10
        height: parent.height - 10
        y: -parent.height
        layer.enabled: true
        color: Cfg.colors.mainBG

        border {
            color: Cfg.colors.border
            width: 1.5
        }

        Rectangle {
            id: mediaImage

            height: parent.height
            width: parent.width * 0.4
            z: 1
            color: "transparent"
            radius: 50

            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }

            Image {
                id: sourceItem

                source: Mpris.albumImage
                anchors.centerIn: parent
                anchors.fill: parent
                width: parent.width
                height: parent.height
                visible: false
            }

            MultiEffect {
                source: sourceItem
                anchors.fill: sourceItem
                maskEnabled: true
                maskSource: mask
            }

            Item {
                id: mask

                width: sourceItem.width
                height: sourceItem.height
                layer.enabled: true
                visible: false

                Rectangle {
                    width: sourceItem.width
                    height: sourceItem.height
                    color: "black"
                    radius: 50
                    z: 1
                }

            }

        }

        ColumnLayout {
            id: mediainfocontrols

            height: parent.height
            width: parent.width - mediaImage.width
            spacing: 10

            anchors {
                left: mediaImage.right
                right: parent.right
                top: parent.top
                bottom: parent.bottom
            }

            Rectangle {
                id: mediainformation

                color: "transparent"
                width: parent.width
                height: parent.height - 70
                Layout.alignment: Qt.AlignHCenter && Qt.AlignVCenter
                topRightRadius: 50
                z: 1

                ColumnLayout {
                    anchors.fill: parent
                    height: parent.height
                    width: parent.width

                    Item {
                        Layout.alignment: Qt.AlignHCenter && Qt.AlignVCenter
                        Layout.fillWidth: true
                        clip: true
                        height: childrenRect.height

                        Text {
                            id: title

                            text: Mpris.mediaTitle
                            font.pixelSize: 14
                            font.family: Cfg.font
                            font.bold: true
                            color: Cfg.colors.color1
                            visible: true
                            anchors.centerIn: parent
                        }

                    }

                    Item {
                        Layout.alignment: Qt.AlignHCenter && Qt.AlignVCenter
                        Layout.fillWidth: true
                        clip: true
                        height: childrenRect.height

                        Text {
                            id: artist

                            text: Mpris.artist
                            font.pixelSize: 12
                            font.bold: false
                            font.family: Cfg.font
                            color: Cfg.colors.color2
                            visible: true
                            anchors.centerIn: parent
                        }

                    }

                }

            }

            Rectangle {
                id: mediaslidertime

                height: 20
                width: parent.width
                z: 1
                color: "transparent"
                Layout.alignment: Qt.AlignHCenter && Qt.AlignVCenter
                Layout.fillWidth: true

                ColumnLayout {
                    Layout.alignment: Qt.AlignHCenter
                    height: parent.height
                    width: parent.width

                    Rectangle {
                        // FrameAnimation {
                        //     // only emit the signal when the position is actually changing.
                        //     running: player.playbackState == MprisPlaybackState.Playing
                        //     // emit the positionChanged signal every frame.
                        //     onTriggered: player.positionChanged()
                        // }
                        // Timer {
                        //     // only emit the signal when the position is actually changing.
                        //     running: player.playbackState == MprisPlaybackState.Playing
                        //     // Make sure the position updates at least once per second.
                        //     interval: 1000
                        //     repeat: true
                        //     // emit the positionChanged signal every second.
                        //     onTriggered: player.positionChanged()
                        // }

                        id: slider

                        Layout.alignment: Qt.AlignHCenter
                        width: parent.width
                        height: 10
                        color: "transparent"

                        Slider {
                            id: mediaSlider
														value: Mpris.position
														live: true
														pressed: true
to: 1.5
onMoved{}
                            Layout.alignment: Qt.AlignHCenter
                            anchors.centerIn: parent
                            width: parent.width - 30
                            onValueChanged: {
                                Mpris.seek(slider.value);
                            }
                        }

                    }

                    RowLayout {
                        width: parent.width
                        height: childrenRect.height
                        Layout.alignment: Qt.AlignHCenter

                        Text {
                            id: mediaLength

                            text: Mpris.mediaLength
                            font.pixelSize: 10
                            font.bold: true
                            font.family: Cfg.font
                            color: Cfg.colors.color1
                        }

                        Rectangle {
                            width: parent.width - mediaLength.width - mediaPosition.width - 100
                            color: "transparent"
                        }

                        Text {
                            id: mediaPosition

                            text: Mpris.mediaPosition
                            font.pixelSize: 10
                            font.bold: true
                            font.family: Cfg.font
                            color: Cfg.colors.color1
                        }

                    }

                }

            }

            Rectangle {
                id: controls

                color: "transparent"
                height: 30
                width: parent.width
                z: 1
                bottomRightRadius: 50
                Layout.alignment: Qt.AlignHCenter && Qt.AlignVCenter

                GridLayout {
                    // anchors.right: parent.right
                    columns: 3
                    height: parent.height
                    width: parent.width

                    Rectangle {
                        width: 20
                        height: 20
                        radius: 15
                        color: "transparent"
                        Layout.alignment: Qt.AlignHCenter

                        Text {
                            text: ""
                            anchors.centerIn: parent
                            font.pixelSize: 20
                            font.family: Cfg.font
                            color: Cfg.colors.color1

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    parent.color = Cfg.colors.color4;
                                }
                                onExited: {
                                    parent.color = Cfg.colors.color1;
                                }
                                onClicked: {
                                    Mpris.backClick();
                                }
                            }

                        }

                    }

                    Rectangle {
                        width: 20
                        height: 20
                        radius: 15
                        color: "transparent"
                        Layout.alignment: Qt.AlignHCenter

                        Text {
                            text: Mpris.mediaStatus
                            anchors.centerIn: parent
                            font.pixelSize: 20
                            font.family: Cfg.font
                            color: Cfg.colors.color1

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    parent.color = Cfg.colors.color2;
                                }
                                onExited: {
                                    parent.color = Cfg.colors.color1;
                                }
                                onClicked: {
                                    if (Mpris.playing == false)
                                        Mpris.playClick();
                                    else
                                        Mpris.pauseClick();
                                }
                            }

                        }

                    }

                    Rectangle {
                        width: 20
                        height: 20
                        radius: 15
                        color: "transparent"
                        Layout.alignment: Qt.AlignHCenter

                        Text {
                            text: ""
                            anchors.centerIn: parent
                            font.pixelSize: 16
                            font.family: Cfg.font
                            color: Cfg.colors.color1

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    parent.color = Cfg.colors.color3;
                                }
                                onExited: {
                                    parent.color = Cfg.colors.color1;
                                }
                                onClicked: {
                                    Mpris.nextClick();
                                }
                            }

                        }

                    }

                }

            }

        }

    }

    mask: Region {
        item: mediaInterface
    }

}
