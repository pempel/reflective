function Chart(a,b){this.uid=a,this.gid=b}function ChartByCompanies(){Chart.call(this,"chart-by-companies","jobs")}function ChartByPositions(){Chart.call(this,"chart-by-positions","jobs")}function setCurrentLocale(a){"undefined"==typeof a&&(a="undefined"==typeof $.cookie(a)?"en":$.cookie("locale")),$.cookie("locale",/ru/.test(a)?"ru":"en"),$(document).attr("title",$(".details h1[lang="+$.cookie("locale")+"]").text()),$("body").attr("class",$.cookie("locale")),$("#locale-links a").removeClass("active"),$("#locale-links a[href="+$.cookie("locale")+"]").addClass("active")}function setCurrentTime(){var a=new Date,b=a.getTime(),c=60*a.getTimezoneOffset()*1e3,d=144e5,e=b+c+d,f=new Date(e),g=f.getHours();10>g&&(g="0"+g);var h=f.getMinutes();10>h&&(h="0"+h),document.getElementById("time").innerHTML=g+":"+h,setTimeout(setCurrentTime,1e3)}Chart.prototype={constructor:Chart,labels:function(){return[]},values:function(){return[]},width:function(){return 550},height:function(){return(this.barHeight()+this.barYOffset())*this.values().length},barXOffset:function(){var a=this.labels().sort(function(a,b){return b.length-a.length});return 8*a[0].length},barYOffset:function(){return 5},barWidth:function(){var a=Math.max.apply(null,this.values());return(this.width()-this.barXOffset())/a},barHeight:function(){return 27},draw:function(){var a=this.barXOffset(),b=this.barYOffset(),c=this.barWidth(),d=this.barHeight(),e=this.values(),f=this.labels(),g=d3.select("[data-chart-group-id="+this.gid+"] .chart").append("svg").attr("id",this.uid).attr("width",this.width()).attr("height",this.height());g.selectAll(".bar").data(e).enter().append("rect").attr("class","bar").attr("width",function(a){return a*c}).attr("height",d).attr("x",a).attr("y",function(a,c){return c*(d+b)}),g.selectAll(".bar-text").data(e).enter().append("text").text(function(a){return a}).attr("class","bar-text").attr("x",function(b){return b*c+a-8}).attr("y",function(a,c){return c*(d+b)+d/2}),g.selectAll(".label").data(f).enter().append("rect").attr("class","label").attr("width",a).attr("height",d).attr("x",0).attr("y",function(a,c){return c*(d+b)}),g.selectAll(".label-text").data(f).enter().append("text").text(function(a){return a}).attr("class","label-text").attr("x",10).attr("y",function(a,c){return c*(d+b)+d/2})}},ChartByCompanies.prototype=Object.create(Chart.prototype,{constructor:{configurable:!0,enumerable:!0,value:ChartByCompanies,writable:!0}}),ChartByCompanies.prototype.labels=function(){return["Leader Telecom","Intellect Design","Crowd Systems","Business Car","Yandex","Business Car","CQG","Informicus"]},ChartByCompanies.prototype.values=function(){return[1,4,4,17,5,9,4,5]},ChartByPositions.prototype=Object.create(Chart.prototype,{constructor:{configurable:!0,enumerable:!0,value:ChartByPositions,writable:!0}}),ChartByPositions.prototype.labels=function(){return["Ruby on Rails Developer","Django Developer","C++ Developer","C# Developer"]},ChartByPositions.prototype.values=function(){return[26,14,4,5]},$(document).ready(function(){var a=[new ChartByCompanies,new ChartByPositions];a.forEach(function(a){a.draw()});var b=$(".chart-group-link");b.click(function(a){a.preventDefault(),b.removeClass("active"),b.each(function(){$("#"+$(this).data("chart-id")).hide()}),$(this).addClass("active"),$("#"+$(this).data("chart-id")).show()}),b.first().click()}),$(document).ready(function(){setCurrentLocale(),$("#locale-links a").click(function(a){a.preventDefault(),setCurrentLocale($(a.target).attr("href"))})}),$(document).ready(function(){var a=!1,b=$("nav .section-links").find(".section-link"),c=b.map(function(){var a=$($(this).find("a").attr("href"));return a.length?a:void 0});b.click(function(d){d.preventDefault();var e=$($(this).find("a").attr("href")),f=e.offset().top-e.height();b.removeClass("active"),b.find("a").filter("[href=#"+e.attr("id")+"]").closest(".section-link").addClass("active"),c.each(function(){return $(this).find("i").css({visibility:"hidden"})}),e.find("i").css({visibility:"visible"}),a=!0,setTimeout(function(){a=!1},1e3),$("html, body").animate({scrollTop:f+"px"},500)}),$(window).scroll(function(){var d=$(this).scrollTop();$("nav").css(d>=$("aside").offset().top?{position:"fixed",top:"0"}:{position:"relative",top:"auto"}),a===!1&&(b.removeClass("active"),c.each(function(){return $(this).find("i").css({visibility:"hidden"})}))})}),$(window).load(function(){setCurrentTime()});