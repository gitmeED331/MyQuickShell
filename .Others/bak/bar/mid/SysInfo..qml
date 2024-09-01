import "../../"
import "../../icons/"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell

RowLayout {
    Rectangle {
        Item {
            Image {
                id: battery

                sourceSize.width: 35
                sourceSize.height: 35
                source: "../../icons/battery.svg"
            }

        }

        Item {
            Image {
                id: internet

                sourceSize.width: parent.height - 10
                sourceSize.height: parent.height - 10
                source: "../../icons/ethernet.svg"
            }

        }

        Audio {
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }

        }

    }

}
