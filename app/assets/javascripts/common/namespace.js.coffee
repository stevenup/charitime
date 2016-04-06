###
Namespace support for coffee, refer to {https://github.com/jashkenas/coffeescript/wiki/FAQ#unsupported-features}

@param {String} target Target namespace which name should be attached to
@param {String} name The namespace we are defining
@param {Function} block Function block to be defined by the namespace
@example
  namespace 'Hello.World', (exports) ->
    # `exports` is where you attach namespace members
    exports.hi = -> console.log 'Hi World!'

  namespace 'Say.Hello', (exports, top) ->
    # `top` is a reference to the main namespace
    exports.fn = -> top.Hello.World.hi()

  Say.Hello.fn()  # prints 'Hi World!'
###
window.namespace = (target, name, block) ->
  [target, name, block] = [(if typeof exports isnt 'undefined' then exports else window), arguments...] if arguments.length < 3
  top    = target
  target = target[item] or= {} for item in name.split '.'
  block target, top

###
Refer to {http://spin.atomicobject.com/2012/03/01/using-namespaces-in-coffeescript/}
A better solution for using namespaces

@example
  doSomethingToo = =>
    using MyApp.Models, MyApp.Util, MyApp.Widgets, (ctx) =>
      book = new ctx.Book
      author = new ctx.Author
      thing = new ctx.Thinger ctx.escape(book.get('name')), ctx.escape(author.get('name'))
###
window.using = (namespaces..., block) ->
  context = {}
  for ns in namespaces
    for k, v of ns
      if context[k]?
        throw "Unable to import namespace: symbol [#{k}] already imported!"
      context[k] = v
  block(context)