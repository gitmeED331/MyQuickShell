import QtQuick
import Quickshell
// Icon config file
pragma Singleton

Singleton {
    id: root

    property QtObject speaker

    speaker: QtObject {
        property string muted: "audio-volume-muted-symbolic"
        property string low: "audio-volume-low-symbolic"
        property string medium: "audio-volume-medium-symbolic"
        property string high: "audio-volume-high-symbolic"
        property string overamplified: "audio-volume-overamplified-symbolic"
    }

}
