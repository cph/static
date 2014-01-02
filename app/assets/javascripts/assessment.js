$(function() {
  // jQuery time
  var current_fs, next_fs, previous_fs; // fieldsets
  var left, opacity, scale; // fieldset properties which we will animate
  var animating; // flag to prevent quick multi-click glitches
  
  $('.score-pass-checkbox').click(function() {
    var $checkbox = $(this),
        id = $checkbox.attr('data-disable'),
        checked = $checkbox.prop('checked'),
        $input = $('#' + id),
        $slider = $('#' + id + '-slider');
    $input.prop('disabled', checked);
    $slider.toggleClass('disabled', checked);
  });
  
  $('.score-pass-checkbox:checked').each(function() {
    var $checkbox = $(this),
        id = $checkbox.attr('data-disable'),
        $input = $('#' + id),
        $slider = $('#' + id + '-slider');
    $input.prop('disabled', true);
    $slider.toggleClass('disabled', true);
  });
  
  $('#progressbar li').click(function() {
    var active_index = $('#progressbar li.active').last().index(),
        target_index = $(this).index();
    if(active_index == target_index) {
      return;
    } else if(target_index < active_index) {
      current_fs = $('#msform fieldset').eq(active_index);
      previous_fs = $('#msform fieldset').eq(target_index);
      animateBackward(current_fs, previous_fs);
    } else {
      current_fs = $('#msform fieldset').eq(active_index);
      next_fs = $('#msform fieldset').eq(target_index);
      animateForward(current_fs, next_fs);
    }
  });
  
  function animateForward(current_fs, next_fs) {
    if(animating) return false;
    animating = true;
    
    // activate next step on progressbar using the index of next_fs
    $('#progressbar li').slice(0, $('fieldset').index(next_fs) + 1).addClass('active');
    
    // show the next fieldset
    next_fs.show(); 
    $('#skill_name').html(next_fs.data('skill-name'));
    $('#skill_category').html(next_fs.data('skill-category'));
    var $form = $('#msform');
    $.ajax({
      url: $form.attr('action'),
      type: 'PUT',
      data: current_fs.serialize()
    });
    
    // hide the current fieldset with style
    current_fs.animate({opacity: 0}, {
      step: function(now, mx) {
        // as the opacity of current_fs reduces to 0 - stored in 'now'
        // 1. scale current_fs down to 80%
        scale = 1 - (1 - now) * 0.2;
        // 2. bring next_fs from the right(50%)
        left = (now * 50) + '%';
        // 3. increase opacity of next_fs to 1 as it moves in
        opacity = 1 - now;
        current_fs.css({'transform': 'scale(' + scale + ')'});
        next_fs.css({'left': left, 'opacity': opacity});
      }, 
      duration: 800, 
      complete: function(){
        current_fs.hide();
        animating = false;
      },
      // this comes from the custom easing plugin
      easing: 'easeInOutBack'
    });
  }
  
  function animateBackward(current_fs, previous_fs) {
    if(animating) return false;
    animating = true;
    
    // de-activate current step on progressbar
    $('#progressbar li').slice($('fieldset').index(previous_fs) + 1).removeClass('active');
    
    // show the previous fieldset
    previous_fs.show();
    $('#skill_name').html(previous_fs.data('skill-name'));
    $('#skill_category').html(previous_fs.data('skill-category'));
    
    // hide the current fieldset with style
    current_fs.animate({opacity: 0}, {
      step: function(now, mx) {
        // as the opacity of current_fs reduces to 0 - stored in 'now'
        // 1. scale previous_fs from 80% to 100%
        scale = 0.8 + (1 - now) * 0.2;
        // 2. take current_fs to the right(50%) - from 0%
        left = ((1-now) * 50) + '%';
        // 3. increase opacity of previous_fs to 1 as it moves in
        opacity = 1 - now;
        current_fs.css({'left': left});
        previous_fs.css({'transform': 'scale(' + scale + ')', 'opacity': opacity});
      },
      duration: 800,
      complete: function() {
        current_fs.hide();
        animating = false;
      },
      // this comes from the custom easing plugin
      easing: 'easeInOutBack'
    });
  }
  
  $('.next').click(function() {
    current_fs = $(this).parent();
    next_fs = $(this).parent().next();
    
    animateForward(current_fs, next_fs);
  });

  $('.previous').click(function() {
    current_fs = $(this).parent();
    previous_fs = $(this).parent().prev();
    
    animateBackward(current_fs, previous_fs);
  });

  $('.submit').click(function() {
    return false;
  });
});
