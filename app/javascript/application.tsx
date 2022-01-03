import React from 'react'
import ReactDOM from 'react-dom'
import Inglip from "./inglip";

document.addEventListener('DOMContentLoaded', function() {
    const container = document.getElementById('inglip')
    if (container) {
        ReactDOM.render(<Inglip/>, container)
    }
})
