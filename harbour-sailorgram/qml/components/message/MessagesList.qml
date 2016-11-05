import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.LibQTelegram 1.0
import "../../components/message/input"
import "../../items"
import "../../model"

SilicaListView
{
    property Message selectedMessage: null
    property string selectedMessageText

    property alias messagesModel: messageslist.model

    Connections
    {
        target: messagepanel

        onReplyRequested: {

        }

        onEditRequested: {
            messageslist.headerItem.editMessage = selectedMessage;
            messageslist.headerItem.editMessageText = selectedMessageText;
        }
    }

    id: messageslist
    spacing: Theme.paddingLarge
    cacheBuffer: Screen.height * 2
    verticalLayoutDirection: ListView.BottomToTop
    currentIndex: -1
    clip: true
    Component.onCompleted: messageslist.positionViewAtIndex(model.newMessageIndex, ListView.Center);

    header: MessageListHeader {
        width: parent.width
        topMargin: messageslist.spacing
    }

    delegate: Column {
        width: parent.width
        spacing: Theme.paddingSmall

        NewMessage { id: newmessage; visible: model.isMessageNew }

        Row {
            width: parent.width

            Item {
                id: picontainer
                anchors.top: parent.top
                x: Theme.paddingSmall
                height: peerimage.height

                width: {
                    if(messagesModel.isChat && !model.isMessageOut && !model.isMessageService)
                        return peerimage.size;

                    return 0;
                }

                PeerImage
                {
                    id: peerimage
                    size: Theme.iconSizeSmallPlus
                    peer: model.needsPeerImage ? model.item : null
                    visible: model.needsPeerImage
                    backgroundColor: Theme.secondaryHighlightColor
                    foregroundColor: Theme.primaryColor
                    fontPixelSize: Theme.fontSizeExtraSmall
                }
            }

            MessageModelItem {
                width: parent.width - picontainer.width - Theme.paddingSmall
                maxWidth: width * 0.8

                onClicked: {
                    if(messagepanel.expanded) {
                        messagepanel.hide();
                        return;
                    }

                    messageslist.selectedMessage = model.item;
                    messageslist.selectedMessageText = model.messageText;

                    messagepanel.checkActions(model.isMessageOut)
                    messagepanel.show();
                }
            }
        }
    }

    VerticalScrollDecorator { flickable: messageslist }
}
