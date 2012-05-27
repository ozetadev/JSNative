function viewLoaded()
{
    var header = new Header();
    header.title = "JSNative";
    header.tint = "red";
    header.frame = [0,0,320,44];
    header.render();
    
    var button = new Button();
    button.title = "Click Me?";
    button.onclick = "buttonClicked";
    button.frame = [10,20,300,44];
    scroller.addSubview(button);
}

function buttonClicked(sender)
{
    /*var alert = new AlertView("You clicked me!", "Congratulations on clicking the button!", "Alright.");
    alert.title = "We can change properties!";
    alert.show();*/
    var topHeader = new Header();
    var rightButton = new BarButtonItem();
    rightButton.title = "Dismiss";
    rightButton.onclick = "dismiss";
    topHeader.title = "Presented!";
    topHeader.tint = "red";
    topHeader.rightBarButtonItem = rightButton;
    topHeader.frame = [0,0,320,44];
    var controller = new ViewController();
    var view = new View();
    var scroll = new ScrollView();
    scroll.frame = [0,0,320,460];
    scroll.contentSize = [320,880];
    scroll.components = [topHeader];
    view.backgroundColor = "underPageBackground";
    view.components = [scroll];
    for (var i = 1; i < 20; i++)
    {
        var newHead = new Header();
        newHead.frame = [0,44*i, 320,44];
        newHead.title = "Header #" + i;
        newHead.tint = "lightGray";
        scroll.components.push(newHead);
    }
        controller.view = view;
    this.presentModalViewController(controller, true);
   
}
function dismiss(sender)
{
    this.dismissModalViewController(true);
}

