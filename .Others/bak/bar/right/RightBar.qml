import "../../"
import "../../icons/"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell

Rectangle {
    RowLayout {
        MediaTicker {
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }

        }

        Clock {
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }

        }

    }

}
