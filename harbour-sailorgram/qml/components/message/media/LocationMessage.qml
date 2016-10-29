import QtQuick 2.1
import Sailfish.Silica 1.0

Column
{
    property alias source: imgmap.source
    property alias color: txtvenue.color
    property string title
    property string address

    id: locationmessage
    width: imgmap.width

    Label
    {
        id: txtvenue
        wrapMode: Text.Wrap
        font.pixelSize: Theme.fontSizeSmall
        visible: (title.length > 0) || (address.length > 0)

        text: {
            if(address.length > 0)
                return title + "\n" + address;

            return title;
        }
    }

    Image
    {
        id: imgmap
        asynchronous: true
        fillMode: Image.PreserveAspectFit
    }
}
