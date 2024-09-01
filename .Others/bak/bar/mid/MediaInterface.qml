import "../../"
import "../../functions/"
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell

PopupWindow {
    property bool mediaTargetVisible: false

    onMediaTargetVisibleChanged: {
        if (mediaTargetVisible) {
            visible = true;
            mediaInterface.y = 0;
        } else {
            mediaInterface.opacity = 0;
        }
    }
    //visible: mediaTargetVisible
    anchor.rect.x: panel.width / 2 - width / 2
    anchor.rect.y: panel.exclusiveZone + 15
    anchor.window: panel
    width: 500
    height: 150
    color: "transparent"

    Rectangle {
        //        property int spacing: 40
        // border {
        //     color: Cfg.colors.border
        //     width: 1.5
        // }

        id: mediaInterface

        radius: 50
        onOpacityChanged: {
            if (opacity == 0) {
                mediaPopup.active = false;
                mediaPopup.loading = true;
            }
        }
        anchors.fill: parent
        anchors.centerIn: parent
        // y: -parent.height
        layer.enabled: true
        color: Cfg.colors.mainBG

        GridLayout {
            columns: 2
            rows: 4
            anchors.fill: parent
            anchors.centerIn: parent

            Rectangle {
                id: mediaImage

                Layout.column: 0
                Layout.rowSpan: 4
                Layout.alignment: Qt.AlignCenter
                Layout.fillHeight: true
                Layout.fillWidth: false
                Layout.preferredWidth: mediaInterface.width * 0.4
                z: 3
                color: "transparent"
                radius: 50

                Image {
                    id: sourceItem

                    source: Mpris.albumImage
                    anchors.centerIn: parent
                    anchors.fill: parent
                    visible: false
                    fillMode: Image.Stretch
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
                        border.color: Cfg.colors.border
                        border.width: 1.5
                        color: "black"
                        radius: 50
                        z: 1
                    }

                }

            }

            Rectangle {
                id: mediainformation

                topRightRadius: 50
                color: "transparent"
                z: 0
                height: 70
                Layout.column: 1
                Layout.row: 0
                Layout.alignment: Qt.AlignCenter
                Layout.fillHeight: true
                Layout.fillWidth: false

                ColumnLayout {
                    anchors.centerIn: parent
                    clip: true

                    Text {
                        id: title

                        x: parent.width / 2
                        Layout.fillWidth: true
                        clip: true
                        text: Mpris.mediaTitle
                        font.pixelSize: 14
                        font.family: Cfg.font
                        font.bold: true
                        color: Cfg.colors.color1
                        visible: true
                    }

                    Text {
                        id: artist

                        x: parent.width / 2
                        Layout.fillWidth: true
                        clip: true
                        text: Mpris.artist
                        font.pixelSize: 12
                        font.bold: false
                        font.family: Cfg.font
                        color: Cfg.colors.color2
                        visible: true
                    }

                }

            }

            Rectangle {
                // FrameAnimation {
                //     // only emit the signal when the position is actually changing.
                //     running: player.playbackState == MprisPlaybackState.Playing
                //     // emit the positionChanged signal every frame.
                //     onTriggered: player.positionChanged()
                // }
                // Timer {
                //     // only emit the signal when the position is actually changing.
                //     running: Mpris.player.playbackState == MprisPlaybackState.Playing
                //     // Make sure the position updates at least once per second.
                //     interval: 1000
                //     repeat: true
                //     // emit the positionChanged signal every second.
                //     onTriggered: Mpris.player.positionChanged()
                // }

                id: mediasliderContainer

                Layout.column: 1
                Layout.row: 1
                Layout.fillWidth: true
                Layout.fillHeight: false
                Layout.alignment: Qt.AlignCenter
                height: 30
                z: 1
                color: "transparent"

                Slider {
                    id: mediaSlider

                    value: Mpris.position ? live : true
                    pressed: true
                    from: 0
                    to: Mpris.mediaLength
                    anchors.centerIn: parent
                    width: parent.width - 30
                    onPositionChanged: Mpris.position = mediaSlider.value
                }

            }

            Rectangle {
                width: parent.width
                height: 12
                color: "transparent"
                Layout.alignment: Qt.AlignCenter
                Layout.fillWidth: true
                Layout.fillHeight: false
                Layout.row: 2
                Layout.column: 1

                RowLayout {
                    width: parent.width
                    height: parent.height

                    Text {
                        id: mediaLength

                        Layout.alignment: Qt.AlignCenter
                        text: Mpris.mediaLength
                        font.pixelSize: 10
                        font.bold: true
                        font.family: Cfg.font
                        color: Cfg.colors.color1
                    }

                    Text {
                        id: mediaPosition

                        Layout.alignment: Qt.AlignCenter
                        text: Mpris.mediaPosition
                        font.pixelSize: 10
                        font.bold: true
                        font.family: Cfg.font
                        color: Cfg.colors.color1
                    }

                }

            }

            Rectangle {
                id: controls

                Layout.column: 1
                Layout.row: 3
                color: "transparent"
                z: 1
                bottomRightRadius: 50
                Layout.alignment: Qt.AlignCenter
                Layout.fillWidth: true
                height: 30

                RowLayout {
                    anchors.fill: parent
                    anchors.centerIn: parent
                    x: +50

                    Item {
                        width: 20
                        height: 20
                        Layout.alignment: Qt.AlignCenter

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

                    Item {
                        width: 20
                        height: 20
                        Layout.alignment: Qt.AlignCenter

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

                    Item {
                        width: 20
                        height: 20
                        Layout.alignment: Qt.AlignCenter

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
