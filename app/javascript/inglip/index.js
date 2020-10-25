"use strict";

const Inglip = {
    components: {},
    autoInitComponents: true,
    initialized: false
};

Inglip.components.wordformFlagToggle = {
    selector: ".wordform-flag-toggle",
    currentFlag: undefined,
    container: undefined,
    inputs: [],
    init: function () {
        this.container = document.querySelector(this.selector);
        if (this.container) {
            this.container.querySelectorAll("input").forEach(this.apply);
            this.currentFlag = this.container.parentNode.querySelector(".current-flag");
        }
    },
    apply: function (element) {
        const component = Inglip.components.wordformFlagToggle;
        component.inputs.push(element);
        element.addEventListener("change", component.handle);
    },
    handle: function (event) {
        const component = Inglip.components.wordformFlagToggle;
        const element = event.target;
        const url = element.dataset.url;
        const verb = element.checked ? 'PUT' : 'DELETE';
        const request = Biovision.jsonAjaxRequest(verb, url, function () {
            const response = JSON.parse(this.responseText);
            if (response.hasOwnProperty("meta")) {
                const meta = response.meta;
                if (meta.hasOwnProperty("flag")) {
                    component.currentFlag.innerHTML = meta.flag;

                    element.indeterminate = false;
                }
            }
        });

        if (!element.indeterminate) {
            element.indeterminate = true;
            request.send();
        }
    },
}

Inglip.components.captcha = {
    selector: ".js-captcha",
    container: undefined,
    button: undefined,
    bidding: undefined,
    url: undefined,
    init: function () {
        this.container = document.querySelector(this.selector);
        if (this.container) {
            const handler = this.handleClick;
            this.button = this.container.querySelector("button");
            this.button.addEventListener("click", handler);
            this.bidding = this.container.querySelector(".bidding");
            this.url = this.container.dataset.url;

        }
    },
    handleClick: function () {
        const component = Inglip.components.captcha;
        const request = Biovision.jsonAjaxRequest("get", component.url, function () {
            const response = JSON.parse(this.responseText);
            if (response.hasOwnProperty("data")) {
                component.bidding.innerHTML = response.data.attributes.text;
                component.button.disabled = false;
            }
        });

        component.button.disabled = true;
        request.send();
    }
}

Inglip.components.analyzer = {
    selector: ".js-analyze-form",
    form: undefined,
    container: undefined,
    init: function () {
        this.form = document.querySelector(this.selector);
        if (this.form) {
            this.apply();
        }
    },
    apply: function () {
        const component = Inglip.components.analyzer;
        this.container = this.form.querySelector(".result");
        this.form.addEventListener("submit", component.handler);
    },
    handler: function (event) {
        event.preventDefault();
        const component = Inglip.components.analyzer;
        const url = component.form.action;
        const request = Biovision.jsonAjaxRequest("post", url, component.process);
        const data = {text: component.form.querySelector(".input-text").value};
        request.send(JSON.stringify(data));
    },
    process: function () {
        const component = Inglip.components.analyzer;
        const response = JSON.parse(this.responseText);
        component.container.innerHTML = "";
        if (response.hasOwnProperty("data")) {
            response.data.forEach(component.addResult);
        }
    },
    addResult: function (data) {
        const component = Inglip.components.analyzer;
        const li = document.createElement("li");
        li.innerHTML = `${data.attributes.body} (${data.attributes.context})`;
        component.container.append(li);
    }
}

window.Inglip = Inglip;

Biovision.components.inglip = Inglip;
