import Quickshell
import QtQuick
import QtQuick.Shapes
import QtQuick.Effects
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

PanelWindow {
  id: bar

  anchors {
    bottom: parent.bottom
    left: parent.left
    right: parent.right
  }
  height: 50
  width: 800

  Rectangle {
    anchors.fill: parent
    topLeftRadius: 20
    topRightRadius: 20
    gradient: Gradient {
      GradientStop { position: 0; color: "#0f9bff" }
      GradientStop { position: 1; color: "#000000" }
      GradientStop { position: 2; color: "#000000" }
      GradientStop { position: 3; color: "#0f9bff" }
    }

    RowLayout {
      anchors.fill: parent
      spacing: 10

      // Left Section
      Rectangle {
        Layout.fillWidth: true
        color: "cyan"
        RowLayout {
          Text { text: "Hyprland Workspaces" }
          // Add active window title with icon here
        }
      }

      // Center Section
      Rectangle {
        Layout.fillWidth: true
        color: "green"
        RowLayout {
          ClockWidget {}
          // Add system tray
          // Add battery and charging status
        }
      }

      // Right Section
      ColumnLayout {
        spacing: 1
        Layout.fillWidth: true

        Rectangle {
          Layout.fillWidth: true
          color: "yellow"
          RowLayout {
            // Add media sticker with popup window for controls
          }
        }

        Rectangle {
          Layout.fillWidth: true
          color: "yellow"
          RowLayout {
            // Add button to access session controls (popup menu containing: lock, logout, restart, shutdown)
          }
        }
      }
    }
  }
}




/*
import Quickshell
import QtQuick
import QtQuick.Shapes
import QtQuick.Effects
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

PanelWindow {
    id: bar

    anchors {
        bottom: true
        left: true
        right: true
    }
    height: 50
    width: 800

    // Layout Start-----------------------
    Rectangle {
        anchors.fill: parent
        topLeftRadius: 20
        topRightRadius:20
        gradient: Gradient {
            GradientStop { position: 0; color: "#0f9bff" }
            GradientStop { position: 1; color: "#000000" }
            GradientStop { position: 2; color: "#000000" }
            GradientStop { position: 3; color: "#0f9bff" }
        }
        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            anchors.fill: parent
            layoutDirection: Qt.LeftToRight
            Layout.margins: 3
            RowLayout {
                id: barleft
                Rectangle {
                    Layout.fillWidth: true
                    color: "cyan"
                    Layout.minimumWidth: bar.width
                    Layout.minimumHeight: bar.height
                    ClockWidget{}
                }
            }
            RowLayout {
                id: barcenter
                Rectangle {
                    Layout.fillWidth: true
                    Layout.minimumWidth: bar.width
                    Layout.minimumHeight: bar.height
                    color: "green"
                    ClockWidget{}
                }
            }
            RowLayout {
                id: barright
                spacing: 1
                layoutDirection: Qt.LeftToRight
                Layout.leftMargin: 10
                ColumnLayout {
                Rectangle {
                    Layout.minimumWidth: clock.implicitWidth
                    Layout.minimumHeight: clock.implicitHeight
                    Layout.fillWidth: true
                    color: "yellow"
                    ClockWidget{
                        id: clock
                        anchors.fill: parent
                        anchors.centerIn: parent
                    }
                Rectangle {
                    Layout.minimumWidth: clock.implicitWidth
                    Layout.minimumHeight: clock.implicitHeight
                    Layout.fillWidth: true
                    color: "yellow"
                    mixer{
                        id: mixer
                        anchors.fill: parent
                        anchors.centerIn: parent
                        }
                }}
                ColumnLayout {
                Rectangle {
                    Layout.fillWidth: true
                    Layout.minimumWidth: powerbtn.implicitWidth
                    Layout.minimumHeight: powerbtn.implicitHeight
                    Layout.column: 1
                    radius: 20
                    color: "pink"
                    Powerbtn{
                        id: powerbtn
                        anchors.fill: parent
                        anchors.centerIn: parent

                    }
                }}
            }
        }
    }//Layout end
    //---------------
}
}
*/
