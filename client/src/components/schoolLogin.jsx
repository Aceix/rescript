import React, {Component} from "react";
import "./schoolLogin.css";
import {NavLink} from "react-router-dom";

export default class SchoolLogin extends Component{
    render(){
        return(
            <div id="main">
                <div className="blacky">
                    <div id="header">
                        Rescript
                    </div>
                    <div className="loginInput">
                        <div className="theTitle">School Log In</div>
                        <input type="email" placeholder="E-mail address"/>
                        <input type="password" placeholder="Password"/>
                        <NavLink to="/schoolpage">
                            <div className="button">
                                Log in
                            </div>
                        </NavLink>
                    </div>
                    
                </div>
            </div>
        );
    }
}