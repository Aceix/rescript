import React,{Component} from "react";
import "./home.css"
import {NavLink} from "react-router-dom";

export default class Home extends Component{
    render(){
        return(
            <div id="main">

                <div id="header">
                    Rescript
                </div>

                <div id="body">
                    <NavLink to="/studentlogin">
                        <div className="option">Log in as student</div>
                    </NavLink>
                    <NavLink to="/schoolLogin">
                        <div className="option">Log in as school</div>
                    </NavLink>
                    <div className="text">
                        Sign up as a <br/><NavLink to="/studentSignUp">Student <br/></NavLink> or <br/> <NavLink to="/schoolSignUp"> School</NavLink>
                    </div>
                </div>
            </div>
        );
    }
}
