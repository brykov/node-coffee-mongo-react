class window.FancyInput extends React.Component
  changeHandler: (e) =>
    data = @state.data
    data[@props.name] = e.target.value
    @setState data: data
  render: =>
    fancy_input_jsx.bind(@)()

