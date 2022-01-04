import React from 'react'
import ReactDOM from 'react-dom'
import Inglip from "./inglip";
import {BrowserRouter as Router} from "react-router-dom";

document.addEventListener('DOMContentLoaded', function () {
    const container = document.getElementById('inglip')
    if (container) {
        ReactDOM.render(<Router><Inglip/></Router>, container)
    }
})
