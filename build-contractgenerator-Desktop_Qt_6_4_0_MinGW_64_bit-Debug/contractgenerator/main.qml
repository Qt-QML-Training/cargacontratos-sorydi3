import QtQuick 2.0
import QtQuick.Controls

import QtQuick.Dialogs

import module.reader


ApplicationWindow  {
    width: 640
    height: 480
    visible: true
    title: qsTr("ContractGenerator")
    id:ventana
    property string backgroundColor: "#fafafa"
    property string darkGrey: "#c7c7c7"

    property var labels;

    property var textInputarr; // hold text input texts

    property var urlSavedFile;

    property string info;

    //file reader instance
    MyFileReader{
        id:fileReader

        onFinishFileRead: {
         var labelss = fileReader.getLabels();
              console.log(labels);
            fileReader.closeFile()
            ventana.labels = labelss
            for(var i=0;i<labels.length;i++){
                listModel.append({label:labels[i],inputTextt:""});
            }
            listView.model = listModel
            listView.visible=true
        }

        onFilenameChanged: {
           fileReader.openFile()
        }


        onFileopened: {
            fileReader.readFile()
        }

        onFileSaved: {
           console.log("file generated succefuly");
            timer.start();
        }

    }


    ListModel{
        id:listModel
}

    //this is the menu bar
    menuBar: MenuBar {
        Menu{
          title: qsTr("&File")

          Action{
              text:qsTr("&Open")
              onTriggered: {
                    ventana.urlSavedFile=""
                    labels=[]
                    listModel.clear()
                    fileDialogg.open()
              }
          }

          Action{
              text:qsTr("&Save")
              onTriggered: {
                  saveFile.open()
              }
          }

          MenuSeparator{}
          Action{text:qsTr("&Quit")
            onTriggered: {Qt.quit()}
          }

        }
    }

    footer: ToolBar{
        Text {
            id: textToolBart
        }
    }


    FileDialog {
         id: fileDialogg
         nameFilters: ["*.txt"]
         onAccepted: {
                console.log("You chose: " + fileDialogg.selectedFile)
                fileReader.filename = fileDialogg.selectedFile
                //bDisplay.visible=false
         }
        onRejected: {
            console.log("Canceled")
            Qt.quit()
        }
     }

    FileDialog{
        id: saveFile


        nameFilters: ["*.pdf"]
        onAccepted: {
            ventana.getTextFieldsTexts();
            console.log("You chose: " + saveFile.selectedFile)
            fileReader.generatePdf(textInputarr);
            fileReader.guardar(saveFile.selectedFile)

            ventana.urlSavedFile = saveFile.selectedFile
            listView.visible=false;

        }
        onRejected: {
            console.log("Canceled")
        }

        fileMode: FileDialog.SaveFile

    }

    Rectangle {
        id:idMainRectangle
        anchors.fill: parent
        gradient: Gradient {
               GradientStop { position: 0.0; color: "#f6f6f6" }
               GradientStop { position: 1.0; color: "#d7d7d7" }
           }
        ListView{
            id:listView
            visible: false
            anchors.fill: parent
            anchors.centerIn: parent
            anchors.leftMargin: 10
            spacing: 10
            clip: true
            anchors.rightMargin: 10
            delegate: LabelInput {
                textLabel: label
                inputText: ""
                onTextInputChanged:(textt)=>{
                    model.inputTextt=textt;
                }
            }

        }

        Component.onDestruction: {
            getTextFieldsTexts();
        }

        Rectangle{
            id:bDisplay

            visible: ventana.urlSavedFile ? true : false

            anchors{

                bottom: parent.bottom
                right: parent.right
                margins: 30

            }

            width: 70
            height: 30

            radius: 5

            color: Qt.lighter("green")

            border.color: Qt.darker(color)

            Text {
                anchors.centerIn: parent
                id: openPdf
                text: qsTr("openPdf")
                font.bold: true
                font.pointSize: 10
                color: "white"
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    print(ventana.urlSavedFile)
                    if(ventana.urlSavedFile){
                        print("displaying pdf...")
                        fileReader.displayPdf(ventana.urlSavedFile)
                    }
                }
            }
        }

    }

    function getTextFieldsTexts(){
        var arr = [];
        for(var i = 0;i<ventana.labels.length;i++){
            var modelItem = listModel.get(i);
            arr.push(modelItem.inputTextt);
            print(modelItem.label+ " "+ modelItem.inputTextt+"\n")
        }
        ventana.textInputarr = arr;
        print(JSON.stringify(arr));
    }

    Timer{

        id: timer

        repeat: false
        running: false

        interval: 1000

        onTriggered: {

            textToolBart.text = "File saved in the following path:" + urlSavedFile.split("///")[1]

        }
    }
}
