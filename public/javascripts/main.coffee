templates = {}
templates['App'] = require './templates/app.jsx'
templates['TypeBox'] = require './templates/type_box.jsx'
templates['FancyInput'] = require './templates/fancy_input.jsx'

class window.FancyInput extends React.Component
  componentWillMount: =>
    @setState { data: @props.provider.state.data }
  changeHandler: (e) =>
    data = @state.data
    data[@props.name] = e.target.value
    @setState data: data
  render: =>
    templates['FancyInput'].bind(@)()


class window.TypeBox extends React.Component
  editMode: =>
    @setState editMode: true
  cancelEditMode: =>
    if @state.data._new
      return @props.app.delNodeType(@state.data)
    @setState
      editMode: false
      data: _.clone(@data_copy)
  save: =>
    @props.app.save()
    @data_copy = _.clone(@state.data)
    @setState
      editMode: false
      _new: false
  componentWillMount: =>
    @setState {
      editMode: !!@props.data._new
      data: @props.data
    }
  componentDidMount: =>
    @data_copy = _.clone(@props.data)
  render: =>
    templates['TypeBox'].bind(@)()


class window.App extends React.Component
  componentWillMount: =>
    @setState { node_types: [] }
  newNodeType: =>
    list = @state.node_types
    list.push
      _id: (new Date).valueOf()
      _new: true
      name: ''
      title: ''
    @setState node_types: list
    return
  delNodeType: (el) =>
    list = @state.node_types
    list.splice list.indexOf(el), 1
    @setState node_types: list
    return
  loadNodeTypes: =>
    qwest.get('/node_types').then (xhr, response) =>
      @setState node_types: response['node_types']
      #console.log(response);
      return
    return
  componentDidMount: =>
    @loadNodeTypes()
    return
  save: =>
    qwest.post('/node_types', {node_types: @state.node_types}, dataType: 'json').then((xhr, response) =>
#console.log([xhr, response]);
      if response.success == 'OK'
        @loadNodeTypes()
      return
    ).catch (e, xhr, response) ->
#console.log([e, xhr, response]);
      return
    return
  render: =>
    templates['App'].bind(@)()



ReactDOM.render React.createElement(App), document.getElementById('react-app')
