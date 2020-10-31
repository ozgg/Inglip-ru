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

Inglip.components.analyzePatterns = {
    selector: ".js-analyze-patterns",
    container: undefined,
    textArea: undefined,
    sendButton: undefined,
    list: undefined,
    analyzeUrl: undefined,
    createUrl: undefined,
    init: function () {
        this.container = document.querySelector(this.selector);
        if (this.container) {
            const component = this;
            this.textArea = this.container.querySelector("textarea");
            this.sendButton = this.container.querySelector("button");
            this.analyzeUrl = this.container.dataset.url;
            this.list = this.container.querySelector("ul");
            this.createUrl = this.list.dataset.url;
            this.sendButton.addEventListener("click", component.handleSend);
        }
    },
    handleSend: function () {
        const component = Inglip.components.analyzePatterns;
        const request = Biovision.jsonAjaxRequest("post", component.analyzeUrl, component.showResults);
        component.list.innerHTML = "";
        component.sendButton.disabled = true;
        request.send(JSON.stringify({"text": component.textArea.value}));
    },
    showResults: function () {
        const component = Inglip.components.analyzePatterns;
        const response = JSON.parse(this.responseText);
        if (response.hasOwnProperty("data")) {
            response.data.forEach(component.addResult);
        }
        component.sendButton.disabled = false;
    },
    addResult: function (data) {
        const component = Inglip.components.analyzePatterns;
        const li = document.createElement("li");
        ['sample', 'pattern'].forEach((field) => {
            const div = document.createElement("div");
            const input = document.createElement("input");
            input.classList.add("input-text", field);
            input.name = `sentence_pattern[${field}]`;
            input.value = data.meta[field];
            div.append(input);
            li.append(div);
        })
        const button = document.createElement("button");
        button.type = "button";
        button.classList.add("button", "button-primary");
        button.innerHTML = "+";
        li.append(button);
        component.list.append(li);

        button.addEventListener("click", component.handleCreate);
    },
    handleCreate: function (event) {
        const component = Inglip.components.analyzePatterns;
        const button = event.target;
        const container = button.closest("li");
        const data = new FormData();
        container.querySelectorAll("input").forEach((input) => {
            data.append(input.name, input.value);
        });
        const request = Biovision.newAjaxRequest("post", component.createUrl, () => {
            container.remove();
        }, () => button.disabled = false);
        button.disabled = true;
        request.send(data);
    }
}

window.Inglip = Inglip;

Biovision.components.inglip = Inglip;
