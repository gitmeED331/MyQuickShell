import "../../"
import "../../icons/"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell

RowLayout {
    //                 id: linkTracker

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

    Rectangle {
        property bool isHovered: false

        Layout.preferredWidth: isHovered ? battery.width + internet.width + timeDate.width + 25 * 2 : 145
        height: panel.exclusiveZone - 5
        radius: 50
        Layout.alignment: Qt.AlignCenter
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
