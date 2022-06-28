import React from "react";

class Toggle extends React.Component {
  constructor(props) {
    super(props);
    this.state = { isToggleon: true };

    this.handleClick = this.handleClick.bind(this);
  }

  handleClick() {
    console.log("handleClick");
    console.log(this);
    this.setState((prevState) => ({
      isToggleon: !prevState.isToggleon,
    }));
  }

  componentDidMount() {
    console.log("componentDidMount");
    console.log(this);
  }

  render() {
    console.log("render");
    console.log(this);
    return (
      <button onClick={this.handleClick}>
        {this.state.isToggleon ? "ON" : "OFF"}
      </button>
    );
  }
}

export default Toggle;
