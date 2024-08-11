import "./bar/left"
import "./bar/mid"
import "./bar/right"
import QtQuick
import Quickshell
import Quickshell.Wayland

ShellRoot {
    ReloadPopup {
    }

    Variants {
        model: Quickshell.screens

        delegate: Component {
            PanelWindow {
                id: panel

                property var modelData

                screen: modelData
                height: screen.height
                width: screen.width
                exclusiveZone: 40
                color: "transparent"

                anchors {
                    top: true
                    left: true
                    right: true
                }

                Item {
                    id: rect

                    width: screen.width
                    height: panel.exclusiveZone

                    LazyLoader {
                        id: audioMixerPopup

                        loading: true

                        AudiomixerInterface {
                        }

                    }

                    Lbar {
                        anchors {
                            bottom: parent.bottom
                            left: parent.left
                            leftMargin: 10
                        }

                    }

                    Mbar {
                        anchors {
                            bottom: parent.bottom
                            horizontalCenter: parent.horizontalCenter
                        }

                    }

                    Rbar {
                        anchors {
                            bottom: parent.bottom
                            right: parent.right
                            rightMargin: 10
                        }

                    }

                    LazyLoader {
                        id: mediaPopup

                        loading: true

                        MediaInterface {
                        }

                    }

                }

                mask: Region {
                    item: rect
                }

            }

        }

    }

}
