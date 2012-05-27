function AlertView(title,message,button) {
    this.title = title;
    this.message = message;
    this.button = button;
    this.show = function()
    {
        window.open("appkit://?method=alert&parameters=" + JSON.stringify(this));
    }
 
}

function Button()
{	
	function randomString() {
	var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
	var string_length = 20;
	var randomstring = '';
	for (var i=0; i<string_length; i++) {
		var rnum = Math.floor(Math.random() * chars.length);
		randomstring += chars.substring(rnum,rnum+1);
	}
	return randomstring;
	}
    
	this.kind = "Button";
	this.frame = [0,0,0,0];
	this.title = "";
	this.onclick = "";
	this.textColor = "black";
	this.name = randomString();
	this.renderInto = function(object)
	{
        this.context = object.name;
        window.open("appkit://?method=render&parameters=" + JSON.stringify(this));
	}
	this.render =  function()
	{
        window.open("appkit://?method=render&parameters=" + JSON.stringify(this));
	}
    this.addSubview = function(object)
    {
        object.renderInto(this);
    }

}
function ScrollView()
{	
	function randomString() {
        var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
        var string_length = 20;
        var randomstring = '';
        for (var i=0; i<string_length; i++) {
            var rnum = Math.floor(Math.random() * chars.length);
            randomstring += chars.substring(rnum,rnum+1);
        }
        return randomstring;
	}
    this.addSubview = function(object)
    {
        object.renderInto(this);
    }
	this.kind = "ScrollView";
	this.frame = [0,0,0,0];
    this.contentSize = [0,0];
	this.name = randomString();
	this.renderInto = function(object)
	{
        this.context = object.name;
        window.open("appkit://?method=render&parameters=" + JSON.stringify(this));
	}
	this.render =  function()
	{
        window.open("appkit://?method=render&parameters=" + JSON.stringify(this));
	}
    
}
function Header()
{	
	function randomString() {
        var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
        var string_length = 20;
        var randomstring = '';
        for (var i=0; i<string_length; i++) {
            var rnum = Math.floor(Math.random() * chars.length);
            randomstring += chars.substring(rnum,rnum+1);
        }
        return randomstring;
	}
	this.kind = "Header";
	this.frame = [0,0,320,44];
	this.title = "";
	this.name = randomString();
	this.renderInto = function(object)
	{
        this.context = object.name;
        window.open("appkit://?method=render&parameters=" + JSON.stringify(this));
	}
	this.render =  function()
	{
        window.open("appkit://?method=render&parameters=" + JSON.stringify(this));
	}
    this.addSubview = function(object)
    {
        object.renderInto(this);
    }
    
}
function View()
{
    function randomString() {
        var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
        var string_length = 20;
        var randomstring = '';
        for (var i=0; i<string_length; i++) {
            var rnum = Math.floor(Math.random() * chars.length);
            randomstring += chars.substring(rnum,rnum+1);
        }
        return randomstring;
	}
	this.kind = "View";
	this.name = randomString();
    this.components = [];
}
function ViewController()
{
    function randomString() {
        var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
        var string_length = 20;
        var randomstring = '';
        for (var i=0; i<string_length; i++) {
            var rnum = Math.floor(Math.random() * chars.length);
            randomstring += chars.substring(rnum,rnum+1);
        }
        return randomstring;
	}
	this.kind = "ViewController";
    this.view = null;
	this.name = randomString();
}
function Web()
{	
	function randomString() {
        var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
        var string_length = 20;
        var randomstring = '';
        for (var i=0; i<string_length; i++) {
            var rnum = Math.floor(Math.random() * chars.length);
            randomstring += chars.substring(rnum,rnum+1);
        }
        return randomstring;
	}
	this.kind = "WebView";
	this.frame = [0,0,320,44];
	this.name = randomString();
    this.location = "";
	this.renderInto = function(object)
	{
        this.context = object.name;
        window.open("appkit://?method=render&parameters=" + JSON.stringify(this));
	}
	this.render =  function()
	{
        window.open("appkit://?method=render&parameters=" + JSON.stringify(this));
	}
    this.addSubview = function(object)
    {
        object.renderInto(this);
    }
    
}
function BarButtonItem()
{	
	function randomString() {
        var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
        var string_length = 20;
        var randomstring = '';
        for (var i=0; i<string_length; i++) {
            var rnum = Math.floor(Math.random() * chars.length);
            randomstring += chars.substring(rnum,rnum+1);
        }
        return randomstring;
	}
	this.kind = "BarButtonItem";
	this.name = randomString();
    this.title = "";
    this.onclick = "";
}

function presentModalViewController(controller, animated)
{
    controller.animated = animated;
    window.open("appkit://?method=present&parameters=" + JSON.stringify(controller));
}
function dismissModalViewController(animated)
{
    window.open("appkit://?method=dismiss&parameters=" + JSON.stringify([]));
}
function pausecomp(ms) {
    ms += new Date().getTime();
    while (new Date() < ms){}
} 

