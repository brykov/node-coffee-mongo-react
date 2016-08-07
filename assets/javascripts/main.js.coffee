#= require 'lib/react-with-addons'
#= require 'lib/react-dom'
#= require 'lib/redux'
#= require 'lib/react-redux'
#= require 'lib/underscore-min'
#= require 'lib/qwest.min'
#= require_tree 'templates'
#= require_tree 'components'

reducer = (state, action) ->
  {foo: 111}
store = Redux.createStore(reducer)
ReactDOM.render React.createElement(App), document.getElementById('react-app')
