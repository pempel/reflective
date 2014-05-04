function setCurrentLocale(a){"undefined"==typeof a&&(a="undefined"==typeof $.cookie(a)?window.navigator.language:$.cookie("locale")),$.cookie("locale",/ru/.test(a)?"ru":"en"),$(document).attr("title",$(".details h1[lang="+$.cookie("locale")+"]").text()),$("body").attr("class",$.cookie("locale")),$("#locale-links a").removeClass("active"),$("#locale-links a[href="+$.cookie("locale")+"]").addClass("active")}function setCurrentTime(){var a=new Date,b=a.getTime(),c=60*a.getTimezoneOffset()*1e3,d=144e5,e=b+c+d,f=new Date(e),g=f.getHours();10>g&&(g="0"+g);var h=f.getMinutes();10>h&&(h="0"+h),document.getElementById("time").innerHTML=g+":"+h,setTimeout(function(){setCurrentTime()},1e3)}var companies=["Leader Telecom","Intellect Design","Crowd Systems","Business Car","Yandex","Business Car","CQG","Informicus"],dataset=[1,4,4,17,5,9,4,5],chartWidth=600,chartHeight=250,barMargin=5,barWidth=(chartWidth-125)/Math.max.apply(null,dataset),barHeight=(chartHeight-barMargin*(dataset.length-1))/dataset.length,svg=d3.select(".chart-area").append("svg").attr("id","chart-by-companies").attr("width",chartWidth).attr("height",chartHeight);svg.selectAll("rect").data(dataset).enter().append("rect").attr("class","bar").attr("x",0).attr("y",function(a,b){return b*(barHeight+barMargin)}).attr("width",function(a){return a*barWidth+125}).attr("height",function(){return barHeight}),svg.selectAll(".label").data(dataset).enter().append("rect").attr("class","label").attr("x",0).attr("y",function(a,b){return b*(barHeight+barMargin)}).attr("width",125).attr("height",barHeight),svg.selectAll(".months").data(dataset).enter().append("text").attr("class","months").text(function(a){return a}).attr("x",function(a){return a*barWidth+125-10}).attr("y",function(a,b){return b*(barHeight+barMargin)+barHeight/2}),svg.selectAll(".company").data(companies).enter().append("text").attr("class","company").text(function(a,b){return companies[b]}).attr("x",function(){return 10}).attr("y",function(a,b){return b*(barHeight+barMargin)+barHeight/2});var positions=["Rails Developer","Django Developer","C++ Developer","C# Developer"],dataset=[26,14,4,5],chartWidth=600,chartHeight=125,labelWidth=138,barMargin=5,barWidth=(chartWidth-labelWidth)/Math.max.apply(null,dataset),barHeight=(chartHeight-barMargin*(dataset.length-1))/dataset.length,svg=d3.select(".chart-area").append("svg").attr("id","chart-by-positions").attr("width",chartWidth).attr("height",chartHeight);svg.selectAll("rect").data(dataset).enter().append("rect").attr("class","bar").attr("x",0).attr("y",function(a,b){return b*(barHeight+barMargin)}).attr("width",function(a){return a*barWidth+labelWidth}).attr("height",function(){return barHeight}),svg.selectAll(".label").data(dataset).enter().append("rect").attr("class","label").attr("x",0).attr("y",function(a,b){return b*(barHeight+barMargin)}).attr("width",labelWidth).attr("height",barHeight),svg.selectAll(".months").data(dataset).enter().append("text").attr("class","months").text(function(a){return a}).attr("x",function(a){return a*barWidth+labelWidth-10}).attr("y",function(a,b){return b*(barHeight+barMargin)+barHeight/2}),svg.selectAll(".company").data(companies).enter().append("text").attr("class","company").text(function(a,b){return positions[b]}).attr("x",function(){return 10}).attr("y",function(a,b){return b*(barHeight+barMargin)+barHeight/2}),$(document).ready(function(){function a(a,b){var c=$("[data-chart-name="+a+"]"),d=$.parseJSON(c.find("script:lang("+b+")").text());console.log(d)}var b=$(".chart-link");b.click(function(a){a.preventDefault(),b.removeClass("active"),b.each(function(){$($(this).data("chart-id")).hide()}),$(this).addClass("active"),$($(this).data("chart-id")).show()}),b.first().click(),window.DS=a}),$(document).ready(function(){setCurrentLocale(),$("#locale-links a").click(function(a){setCurrentLocale($(a.target).attr("href")),a.preventDefault()})}),$(document).ready(function(){var a=!1,b=$("nav .section-links").find(".section-link"),c=b.map(function(){var a=$($(this).find("a").attr("href"));return a.length?a:void 0});window.links=b,window.headers=c,b.click(function(d){d.preventDefault();var e=$($(this).find("a").attr("href")),f=e.offset().top-e.height();b.removeClass("active"),b.find("a").filter("[href=#"+e.attr("id")+"]").closest(".section-link").addClass("active"),c.each(function(){return $(this).find("i").css({visibility:"hidden"})}),e.find("i").css({visibility:"visible"}),a=!0,setTimeout(function(){a=!1},1e3),$("body").animate({scrollTop:f},500)}),$(window).scroll(function(){var d=$(this).scrollTop();$("nav").css(d>=$("aside").offset().top?{position:"fixed",top:"0"}:{position:"relative",top:"auto"}),a===!1&&(b.removeClass("active"),c.each(function(){return $(this).find("i").css({visibility:"hidden"})}))})}),$(window).load(function(){setCurrentTime()});