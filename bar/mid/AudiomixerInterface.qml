import "../../"
import "../../functions/"
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire

PopupWindow {
    id: audiomixerInterface

    property bool mixerTargetVisible: false

    // anchor.rect.x: panel.width / 2 + width / 2
    // anchor.rect.y: panel.exclusiveZone + 15
    anchor.window: panel.output
    width: childrenrect.width + 200
    height: childrenrect.height + 75
    visible: mixerTargetVisible
    color: "transparent"

    Rectangle {
        id: childrenrect

        anchors.fill: parent
        anchors.centerIn: parent
        color: Cfg.colors.mainBG
        radius: 15

        border {
            color: Cfg.colors.border
            width: 1.5
        }

        ScrollView {
            anchors.fill: parent
            anchors.centerIn: parent
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

    }

}
