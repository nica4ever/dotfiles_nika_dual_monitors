import QtQuick 2.0
import SddmComponents 2.0

Rectangle {
    id: container
    width: 640
    height: 480

    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    property int sessionIndex: session.index

    // Tokyo Night palette
    property color tokyoBg: "#1a1b26"
    property color tokyoFg: "#c0caf5"
    property color tokyoBlue: "#7aa2f7"
    property color tokyoCyan: "#7dcfff"
    property color tokyoRed: "#f7768e"
    property color tokyoGreen: "#9ece6a"
    property color tokyoYellow: "#e0af68"
    property color tokyoComment: "#565f89"
    property color tokyoDark: "#24283b"

    TextConstants { id: textConstants }

    Connections {
        target: sddm
        function onLoginSucceeded() {
            errorMessage.color = tokyoGreen
            errorMessage.text = textConstants.loginSucceeded
        }
        function onLoginFailed() {
            password.text = ""
            errorMessage.color = tokyoRed
            errorMessage.text = textConstants.loginFailed
        }
        function onInformationMessage(message) {
            errorMessage.color = tokyoRed
            errorMessage.text = message
        }
    }

    Background {
        anchors.fill: parent
        source: Qt.resolvedUrl(config.background)
        fillMode: Image.PreserveAspectCrop
        onStatusChanged: {
            var defaultBackground = Qt.resolvedUrl(config.defaultBackground)
            if (status == Image.Error && source !== defaultBackground) {
                source = defaultBackground
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"

        Clock {
            id: clock
            anchors.margins: 5
            anchors.top: parent.top; anchors.right: parent.right
            color: tokyoCyan
            timeFont.family: "JetBrains Mono"
        }

        Rectangle {
            id: panel
            anchors.centerIn: parent
            width: Math.max(340, mainColumn.implicitWidth + 60)
            height: Math.max(340, mainColumn.implicitHeight + 60)
            color: Qt.rgba(0.102, 0.106, 0.149, 0.8)
            radius: 16

            Column {
                id: mainColumn
                anchors.centerIn: parent
                spacing: 12

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: tokyoCyan
                    verticalAlignment: Text.AlignVCenter
                    height: text.implicitHeight
                    width: parent.width
                    text: textConstants.welcomeText.arg(sddm.hostName)
                    wrapMode: Text.WordWrap
                    font.pixelSize: 24
                    font.family: "JetBrains Mono"
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignHCenter
                }

                Column {
                    width: parent.width
                    spacing: 4
                    Text {
                        id: lblName
                        width: parent.width
                        text: textConstants.userName
                        color: tokyoCyan
                        font.bold: true
                        font.pixelSize: 12
                        font.family: "JetBrains Mono"
                    }
                    TextBox {
                        id: name
                        width: parent.width; height: 30
                        text: userModel.lastUser
                        font.pixelSize: 14
                        font.family: "JetBrains Mono"
                        color: tokyoBg
                        textColor: tokyoCyan
                        borderColor: "#2f3549"
                        focusColor: "#3b4261"
                        hoverColor: tokyoDark
                        KeyNavigation.backtab: rebootButton; KeyNavigation.tab: password
                        Keys.onPressed: function (event) {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                sddm.login(name.text, password.text, sessionIndex)
                                event.accepted = true
                            }
                        }
                    }
                }

                Column {
                    width: parent.width
                    spacing: 4
                    Text {
                        id: lblPassword
                        width: parent.width
                        text: textConstants.password
                        color: tokyoCyan
                        font.bold: true
                        font.pixelSize: 12
                        font.family: "JetBrains Mono"
                    }
                    PasswordBox {
                        id: password
                        width: parent.width; height: 30
                        font.pixelSize: 14
                        font.family: "JetBrains Mono"
                        color: tokyoBg
                        textColor: tokyoCyan
                        borderColor: "#2f3549"
                        focusColor: "#3b4261"
                        hoverColor: tokyoDark
                        KeyNavigation.backtab: name; KeyNavigation.tab: session
                        Keys.onPressed: function (event) {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                sddm.login(name.text, password.text, sessionIndex)
                                event.accepted = true
                            }
                        }
                    }
                }

                Row {
                    spacing: 4
                    width: parent.width / 2
                    z: 100
                    Column {
                        z: 100
                        width: parent.width * (layoutBox.visible ? 1.3 : 2)
                        spacing: 4
                        anchors.bottom: parent.bottom
                        Text {
                            id: lblSession
                            width: parent.width
                            text: textConstants.session
                            color: tokyoCyan
                            wrapMode: TextEdit.WordWrap
                            font.bold: true
                            font.pixelSize: 12
                            font.family: "JetBrains Mono"
                        }
			
			ComboBox {
                            id: session
                            width: parent.width; height: 30
                            font.pixelSize: 14
                            font.family: "JetBrains Mono"
                            color: tokyoBg
                            textColor: tokyoCyan
                            borderColor: "#2f3549"
                            focusColor: "#3b4261"
                            hoverColor: tokyoDark
                            arrowColor: tokyoBg
                            arrowIcon: Qt.resolvedUrl("angle-down.png")
                            model: sessionModel
                            index: sessionModel.lastIndex
                            KeyNavigation.backtab: password; KeyNavigation.tab: layoutBox
                        }
                        
                    }
                    Column {
                        z: 101
                        width: parent.width * 0.7
                        spacing: 4
                        anchors.bottom: parent.bottom
                        visible: keyboard.enabled && keyboard.layouts.length > 0
                        Text {
                            id: lblLayout
                            width: parent.width
                            text: textConstants.layout
                            color: tokyoCyan
                            wrapMode: TextEdit.WordWrap
                            font.bold: true
                            font.pixelSize: 12
                            font.family: "JetBrains Mono"
                        }
                        LayoutBox {
                            id: layoutBox
                            width: parent.width; height: 30
                            font.pixelSize: 14
                            font.family: "JetBrains Mono"
                            color: tokyoBg
                            textColor: tokyoCyan
                            borderColor: "#2f3549"
                            focusColor: "#3b4261"
                            hoverColor: tokyoDark
                            arrowIcon: Qt.resolvedUrl("angle-down.png")
                            KeyNavigation.backtab: session; KeyNavigation.tab: loginButton
                        }
                    }
                }

                Column {
                    width: parent.width
                    Text {
                        id: errorMessage
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: textConstants.prompt
                        color: tokyoCyan
                        font.pixelSize: 10
                        font.family: "JetBrains Mono"
                    }
                }

                Row {
                    spacing: 4
                    anchors.horizontalCenter: parent.horizontalCenter
                    property int btnWidth: Math.max(loginButton.implicitWidth,
                                                    shutdownButton.implicitWidth,
                                                    rebootButton.implicitWidth, 80) + 8
                    Button {
                        id: loginButton
                        text: textConstants.login
                        width: parent.btnWidth
                        font.family: "JetBrains Mono"
                        color: tokyoBg
                        textColor: tokyoCyan
                        borderColor: "#2f3549"
                        activeColor: tokyoBlue
                        pressedColor: tokyoDark
                        onClicked: sddm.login(name.text, password.text, sessionIndex)
                        KeyNavigation.backtab: layoutBox; KeyNavigation.tab: shutdownButton
                    }
                    Button {
                        id: shutdownButton
                        text: textConstants.shutdown
                        width: parent.btnWidth
                        font.family: "JetBrains Mono"
                        color: tokyoBg
                        textColor: tokyoCyan
                        borderColor: "#2f3549"
                        activeColor: tokyoBlue
                        pressedColor: tokyoDark
                        onClicked: sddm.powerOff()
                        KeyNavigation.backtab: loginButton; KeyNavigation.tab: rebootButton
                    }
                    Button {
                        id: rebootButton
                        text: textConstants.reboot
                        width: parent.btnWidth
                        font.family: "JetBrains Mono"
                        color: tokyoBg
                        textColor: tokyoCyan
                        borderColor: "#2f3549"
                        activeColor: tokyoBlue
                        pressedColor: tokyoDark
                        onClicked: sddm.reboot()
                        KeyNavigation.backtab: shutdownButton; KeyNavigation.tab: name
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        if (name.text === "")
            name.focus = true
        else
            password.focus = true
    }
}
