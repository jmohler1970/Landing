# Introduction
This is a fancy Adobe ColdFusion Landing page. This is also an introduction into

* VueJS
* Bulma, a css responsive design library
* Buefy, a VueJS plugin that expands on Bulma
* Axois, an AJAX library that we will be pluggin into VueJS
* and FontAwesome which provides lots icons




# Let's take a look

Lots of different technologies going on here. Let's take a look at the head tag and see what I am bringing in.


## VueJS
<script src="https://unpkg.com/vue@2.5.17"></script>

What is the VueJS framework?

Let's travel way back in time. I remember the first time I worked with the jQuery library. It was love at first sight. All I had to was bring in the jQuery library (and a few other plugins), and my entire website could have sortable table, searchable pulldown menus, tabs that were AJAX'ed in, fancy datepicker. It make my ColdFusion site shine. And if all that wasn't enough, Twitter Bootstrap 2 came to my attention. I could roll out this functionality fast. This was a good time for me as a ColdFusion developer. The company that I worked for was starting to use a lot of .Net stuff. The .Net developers were struggling to get this to work within Visual Studio. There I was with Macromedia Homesite+ doing some Rapid Application Development. These were good times.

One of the things that intregued me about jQuery was how it was able to use `data-` attributes. These are attributes that are put into HTML tags but don't directly change how the tag works. They are not a part of CSS. You can have as many as you want and jQuery can hook into these and do stuff.

For example on my table sorting pluging, `data-` attributes controlled if a column was sortable. On my searchabl pulldown menu, it controlled its options. This is a powerful idea. jQuery can read them, but it doesn't directly use them. It is up the the plugins decide what to do with them. If only we took this concept one step further.

This is when I saw the first version of AngularJS. It was just filled custom attributes. In its case `ng-` attributes. This video is on VueJS, not AngularJS. So I am going to be brief. I liked the orginal version of AngularJS, but I didn't love it. When version 2 and above became serverside only technlogy. I stopped paying attention to it. Sorry AngularJS and Angular

So what about VueJS?

VueJS is both Client and Server side. It uses custom attributes, in this case `v-`. If you want to do Single Page Applications, it can do it. If you want to make your existing ColdFusion generated pages smarter it can do it. But most importantly, it has an outline of how thing are done. It has a highly flexible, but structured approach. When I am dealing with VueJS code, I know where certain things have to and what they will do.




### Can you use VueJS with jQuery?

There are three parts to my answer:

1. Yes, but you you are asking for trouble

2. Yes, that is interesting

3. No. You are doing it wrong.

Let's start with number one: Yes but you are asking for trouble. 

jQuery attaches itself to everything in the DOM. You use jQuery to manipulate the DOM. VueJS is also DOM manipulating technology. You now have two technologies that are that have the ability to manipulate the same thing.s  This is just asking for one to unexpectantly change something. I suppose if you were careful and had a jQuery only part of a web page and a VueJS only part of a web page it might work. Then again jQuery wants to attach to everything

Let's try number two: Yes, that is is interesting.

jQuery has a built in AJAX library. VueJS does not. If you like how jQuery does AJAX you can use it to do all the AJAX calls and pass the data in and out of VueJS. Having said that, you probably want to consider moving to Axios for AJAX. If focuses on just AJAX and is much lighter than jQuery

Number three: NO. You are doing it wrong!
jQuery takes dumb web pages and makes them smart. VueJS takes dumb web pages and makes them smart. But they have such different approaches. There is no real middle ground. VueJS just requires a different kind of thinking.


### Can you use VueJS with AngularJS (version 1)?

This is the older CDN based version of AngularJS.

Probaby not and even if you could, most likely you are doing both wrong


### Can you use VueJS with Angular (version 2 and above)?

This is the newer server side version.

Probaby not and even if you could, most likely you are doing both wrong


### Can you use VueJS with Bootstrap?

Bootstrap, at least until version 4.1.x requires jQuery in order to run. So does VueJS work with Bootstrap. The answer is it can, but you are missing out on a huge opportunity. VueJS can make web development much smarter. I want the Bootstrap `<div>` with classes to become VueJS custom tags with hooks into VueJS.

At the time of this writing, Bootstrap Vue is a project that does just that. Unfortunately they have not had a release in about six month. I look forward to them doing regular releases, and I will gladly do a video on that technology.

### Conclusion

I have been talking a lot about VueJS and I have shown much code. Let's quickly cover the rest of the technologies.



## Buefy dot min dot css
<link rel="stylesheet" href="https://unpkg.com/buefy/dist/buefy.min.css">
<script src="https://unpkg.com/buefy@0.6.7"></script>

You have to love the names for technology sometimes. Buefy is a combination of two things. Bulma and VueJS


### What is a Bulma?

It is a responsive design, grid based CSS library. If this sounds a lot like what Twitter Bootstrap does, that is because it is. The thing is Bootstrap uses jQuery and JavaScript to get the job done.

Bulma does not do any that. It is pure CSS. As a consquence, it won't run on older browsers and in some areas it has less functionality. On the other had it is a lot smaller and we are free to do Javascript any way we want.

### Back to Buefy

Buefy takes many the Bulma classes and turns them into VueJS custom tags. Making them even smarter. When we start going over the code, keep in mind that we are likely to see VueJS, Bulma, and Buefy all at the same time.


## Axios
<script src="https://unpkg.com/axios@0.18.0/dist/axios.min.js"></script>

As mentioned before VueJS does not built-in AJAX, but Axios can do it. I think Axios is also used on Server Side Javascript and in Angular too. It is in a lot of places.



## Fontawesome
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.2/css/all.css" crossorigin="anonymous">

Lots and lots of icons. I like icons



# Resources


Bulma
https://bulma.io/

Buefy (Vue + Bulma)
https://buefy.github.io/
https://github.com/buefy/buefy


Font Awesome
https://fontawesome.com/


VueJS
https://vuejs.org/
https://github.com/vuejs/vue


Axios
https://github.com/axios/axios


ColdFusion Landing page (This repository)

https://github.com/jmohler1970/Landing


Bootstrap Vue

https://bootstrap-vue.js.org/
