import QtQuick

    //property alias inputText: textInput.text
    Rectangle{
        property alias textLabel: labelNombre.text
        property alias inputText: textInput.text
        property string itemColor: "#b0bec5"
        signal textInputChanged(text:string);
         width: parent.width
         height: 80
         color: itemColor
         anchors.margins: 10
         radius: 10
         id:containerlabeText

             Text {
                 id: labelNombre
                 text: qsTr("Nombre")
                 anchors.top: containerlabeText.top
                 anchors.left: containerlabeText.left
                 anchors.leftMargin: 10
                 anchors.topMargin: 5
             }

           Rectangle{
               id:textInputRectangle
               width: parent.width-20
               height: 30
               anchors{
                   top: labelNombre.bottom
                   left: parent.left
                   right: parent.right
                   margins: 5
                   centerIn: parent
               }

               border.color: "black"
               radius: 5

               TextInput{
                   anchors.fill:parent
                   id : textInput
                   text: "Nombre"
                   anchors.margins: 5

                   onTextChanged: {
                      containerlabeText.textInputChanged(textInput.text);
                   }
               }

           }

    }

