# as3-scrollbar
an actionscript3 scrollbar to use in flash projects

Introducing ScrollbarAS3, from old site fuoridalcerchio.net, a very simple way to add scrollbars in your flash sites! 
It's easy to use even with frameworks like Gaia Framework.

How to use:

* Include Scrollbar.as in your project folder.
* Target a clip in your .fla that needs to be scrolled, create a scrollbar - or use mine, just joking...
* In your .fla timeline, copy this:

````actionscript3
  import Scrollbar; 
  // import scrollbar class
  // create scrollbar instance
  // content = the clip to be scrolled
  // mask = the clip that masks the content and hide the area not visible
  // ruler = the scrollbar ruler
  // background = the scrollbar background
  // hoverarea = active area for mousewheel
  // blurred = is the content blurred while scrolling?
  // blurredAmount = how much is it blurred?
  var sc:Scrollbar = new Scrollbar(content, mask, ruler, background, hoverarea, blurred, blurredAmount);
  // add a listener to stage for waiting for scroll to be attached to it
  sc.addEventListener(Event.ADDED, scInit);
  // add the scrollbar to the stage (or whatever...)
  addChild(sc);
  // as soon as added to the stage, init the scrollbar!
  function scInit(e:Event):void {
    sc.init();
  }
````

* And now test!

have fun
