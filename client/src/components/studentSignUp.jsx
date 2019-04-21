import React, {Component} from "react";
import "./schoolSignUp.css"

export default class StudentSignUp extends Component {
    render(){
        return(
            <div className="signupMain">
                <div className="innerbody">
                    <div className="title">
                        Student Sign Up
                    </div>
            
                    <div className="inputDiv">
                        <input type="text" placeholder="Name"/>

                        <input type="text" placeholder="Previous Institution"/>

                        <input type="number" placeholder="Year completed"/>

                        <input type="number" placeholder="Reference Number"/>

                        <input type="email" placeholder="E-mail address"/>

                        <input type="password" placeholder="Password"/>

                        <input type="text" placeholder="Phone number"/>
                    </div>

                    <div className="button1">Sign Up</div>

                    
                </div>
            </div>
        );
    }
}