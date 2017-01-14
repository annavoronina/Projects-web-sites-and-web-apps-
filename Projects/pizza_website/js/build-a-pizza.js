//your code goes here
$( document ).ready(function() {
    console.log( "ready!" );


//when div.button is clicked  
$('.cart div.button').on('click',function(){
  //animate div.button
  $(this).animate({width: '160px', fontSize: '12px'}, 3000, 'easeOutElastic');
});


//when .toppings-list in clicked
 $('.toppings-list__item-buy').on('click',function(){
  //animate .toppings-list 
  $(this).parents("a").animate({padding: '10px', fontSize: '15px'}, 1000, 'easeOutBounce');
});


//change background and opaity of .filters 
  $(".filters .categories-list__item").animate(
    {
     opacity:0.6,
     backgroundColor:"#ecf9ec"
    },500
  );
 //when .filters on hover 
 $(".filters .categories-list__item").parents("ul").hover(
  //animate .filters +15px left and increase fontSize to +3px
  function(){
    $(this).animate(
      {paddingLeft:"+=15px",
      fontSize:"+=3px"}, 1000,"easeInBounce"
    );
  }
  ,
  //animate .filters -15px left and decrease fontSize -3px
  function(){
    $(this).animate(
      {paddingLeft:"-=15px",
      fontSize:"-=3px"}, 1000, "easeInBounce"
    );
  }
);
  


//when .toppings-list__item-buy is clicked
  $('.toppings-list__item-buy').on('click',function(){
    //append img element to Your pie at a glance
  $(this).parents("a").find("img").last().clone().appendTo(".toppings-list").height(40).width(40).css({padding: "2px"}).animate({marginLeft: '+=4px'},
  2000, 'easeOutBack');
});
    
  
//when .toppings-list__item-buy is clicked
  $('.toppings-list__item-buy').on('click',function(){
    //change the backgroundColor
    $(this).css({ 'backgroundColor': 'red'});
});
   
//when filters is clicked   
$(" .filters .categories-list__item:first-child").click(function() {
  //add css to filters
    $(this).addClass("outline");
    //add cancel button 
      $(".cancel").eq(0).show();
      //add css to toppings-list
        $(".toppings-list-first").addClass("highlight");
        //add css to h4
          $("h4").eq(0).addClass("page-header");
});
  
//when filters is clicked  
$(" .filters .categories-list__item:nth-child(2)").click(function() {
 //add css to filters
  $(this).addClass("outline");
   //add cancel button
    $(".cancel").eq(1).show();
     //add css to toppings-list
      $(".toppings-list-second").addClass("highlight");
       //add css to h4
        $("h4").eq(1).addClass("page-header");
});
   

//when filters is clicked          
$(" .filters .categories-list__item:nth-child(3)").click(function() {
 //add css to filters
  $(this).addClass("outline");
   //add cancel button
    $(".cancel").eq(2).show();
     //add css to toppings-list
      $(".toppings-list-third").addClass("highlight");
       //add css to h4
        $("h4").eq(2).addClass("page-header");
      
});

//when filters is clicked  
$(" .filters .categories-list__item:nth-child(4)").click(function() {
 //add css to filters
  $(this).addClass("outline");
   //add cancel button
    $(".cancel").eq(3).show();
     //add css to toppings-list
      $(".toppings-list-fourth").addClass("highlight");
       //add css to h4
        $("h4").eq(3).addClass("page-header");
      
});

//when filters is clicked  
$(" .filters .categories-list__item:nth-child(5)").click(function() {
 //add css to filters
  $(this).addClass("outline");
   //add cancel button
    $(".cancel").eq(4).show();
     //add css to toppings-list
       $(".toppings-list-fifth").addClass("highlight");
         //add css to h4
          $("h4").eq(4).addClass("page-header");

});
   



//when trash icon is clicked
$(".cart .cart-list__item-discard").click(function() {
  //remove this 
    $(this).parent().remove();

});
  

 
 
 var count = 0;
  //when plus icon is cliked
  $("  .cart-list__item.cf .fa-plus").click(function() {
    count++;
    //increase quantity by 1
    $(".cart .cart-list__item-counter-quantity").html(""+count);
});
  //when minus icon is cliked
  $(".cart .cart-list__item-counter .fa-minus").click(function() {
     count--;
     //decrease quantity by 1
    $(".cart .cart-list__item-counter-quantity").html(""+count);
});
  

  

 //when plus icon is clicked
  $(" .cart-list__item.cf .fa-plus").click(function() {
 
  var price = $(this).parents("li").children(".toppings-list__base-price").text().replace("$","");
  var qty = $(this).parents("li").find(".cart-list__item-counter-quantity").html();
  
      console.log(qty);
  //multiple price by quantity
  $(".cart .cart-list__item-price").html(price*qty);

});
  
 //when minus icon is clicked
  $(" .cart-list__item.cf .fa-minus").click(function() {
   
  var price = $(this).parents("li").children(".toppings-list__base-price").text().replace("$","");
  var qty = $(this).parents("li").find(".cart-list__item-counter-quantity").html();
  
     console.log(qty);
  //multiple price by quantity
  $(".cart .cart-list__item-price").html(price*qty);

});
  
});