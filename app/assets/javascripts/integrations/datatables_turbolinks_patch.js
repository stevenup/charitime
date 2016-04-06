$(window).on("page:before-unload", function(e) {
  if (CKEDITOR && CKEDITOR.instances) {
    for(name in CKEDITOR.instances) {
      if (CKEDITOR.instances.hasOwnProperty(name)) {
        CKEDITOR.instances[name].destroy(true);
      }
    }
  }
});
