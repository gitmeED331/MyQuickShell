import "../../"
import "../../functions/"
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire

PopupWindow {
    // onTargetVisibleChanged: {
    //     if (targetVisible) {
    //         visible = true;
    //         AudiomixerInterface.y = 0;
    //     } else {
    //         AudiomixerInterface.opacity = 0;
    //     }
    // }

    property bool targetVisible: false

    anchor.rect.x: panel.width / 2
    anchor.rect.y: panel.exclusiveZone + 15
    anchor.window: panel
    width: 700
    height: 350
    color: "black"
    visible: targetVisible

    Rectangle {
        id: audiomixerInterface

        width: parent.width
        height: parent.height
        radius: 15
        y: -parent.height
        layer.enabled: true
        color: "pink"
        onOpacityChanged: {
            if (opacity == 0) {
                audioMixerPopup.active = false;
                audioMixerPopup.loading = true;
            }
        }

        ScrollView {
            anchors.fill: parent
            contentWidth: availableWidth

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10

                // get a list of nodes that output to the default sink
                PwNodeLinkTracker {
                    id: linkTracker

                    node: Pipewire.defaultAudioSink
                }

                MixerEntry {
                    node: Pipewire.defaultAudioSink
                }

                Rectangle {
                    Layout.fillWidth: true
                    color: palette.active.text
                    implicitHeight: 1
                }

                Repeater {
                    model: linkTracker.linkGroups

                    MixerEntry {
                        required property PwLinkGroup modelData

                        // Each link group contains a source and a target.
                        // Since the target is the default sink, we want the source.
                        node: modelData.source
                    }

                }

            }

        }

        Behavior on y {
            NumberAnimation {
                duration: 400
                easing.type: Easing.OutBack
            }

        }

        Behavior on opacity {
            NumberAnimation {
                duration: 200
            }

        }

    }

    mask: Region {
        item: audiomixerInterface
    }

}
