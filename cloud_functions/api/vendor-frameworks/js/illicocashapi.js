class IllicoCash {
    /**
    * Constructs a new instance of the class.
    * @param {object} sdapp - The sdapp object.
    * @constructor
    */
    constructor(sdapp) {
        this.paymentApi = this;
    }

    domElements() {

        try {

            const gen = this.gen();

            const setter = function (args) {
                try {
                    const { element, attr = {}, css = {} } = args;
                    attr.id = this.id;
                    attr.name = this.name;

                    if (!element) {
                        return;
                    }

                    if (gen.isDOMElement(element)) {
                        return $(element).attr(attr).css(css);
                    }

                    return $(gen.createEl(element)).attr(attr).css(css);
                }
                catch (error) {
                    throw new Error(`Failed to run setter due this error:${error.message}`);
                }
            };

            const getter = function () {
                try {
                    return $(`#${this.id}`);
                } catch (error) {
                    throw new Error(`Failed to run getter due this error:${error.message}`);
                }
            };

            return {
                paymentcategories: {
                    id: "sdapp-payment-api-payment-categories-id",
                    name: "voting-pricing-categories",
                    setter,
                    getter

                },
                paymenttypes: {
                    id: "sdapp-payment-api-payment-types-id",
                    name: "voting-pricing",
                    setter,
                    getter
                },
                flexpayclientphonenumber: {
                    id: "flexpay-client-phone-number-id",
                    setter,
                    getter
                },
                mobilepaymentradiobutton1: {
                    id: "flexpay-mobile-payment-radio-button-1",
                    name: "flexpay-mobile-payment-radio-button-1",
                    setter,
                    getter
                },
                flexpaypushform: {
                    id: "flexpay-pushform-id",
                    name: "flexpay-pushform-name",
                    setter,
                    getter
                },
                flexpaydynamicformsection: {
                    id: "flexpay-dynamic-form-section-id",
                    name: "flexpay-dynamic-form-section",
                    setter,
                    getter
                }
            };

        } catch (error) {
            throw new Error(`Failed run  domElements due this error:${error.message}`);
        }
    };

    getPaymentCategoryArrayObject = () => {
        try {
            return [
                {
                    key: "illicocash",
                    title: "Illico Cash"
                },
                {
                    key: "flexpay",
                    title: "Mobile Money, Visa"
                }
            ];
        } catch (error) {
            throw new Error(`Failed to  getPaymentCategoryArrayObject due this error:${error.message}`);
        }
    };
    /**
    * Retrieves the voting payment types as a dropdown list.
    * @returns {HTMLElement} The dropdown list of voting payment types.
    */
    getVotingPaymentTypes = (blockId, label) => {
        const gen = this.gen();
        // Retrieve the block columns from the current context
        const blockColumns = this.getBlockColumns(blockId);

        // Retrieve the payment type array
        const paymentList = this.getPaymentTypeArray(blockId);
        // Generate a dropdown list from the payment list array
        return gen.dropDownFromArray({
            array: paymentList,
            // Generate the ID for each dropdown option
            id: (item) => {
                const data = gen.getObjectFromJSON(item.data);
                return data[blockColumns[1]];
            },
            // Generate the output display for each dropdown option
            output: (item) => {
                const data = gen.getObjectFromJSON(item.data);
                return `${data[blockColumns[0]]}  ${data[blockColumns[2]]}`;
            },
            attr: { class: "select-container", name: "voting-pricing" },
            legend: label === "*" ? `Selectionner voix pour voter` : `Selectionner voix pour voter catégorie : ${label}`
        });
    };
    replaceDefaultPaymentTypesWithIllicoCachPaymentTypes(args) {
        try {
            const { e, blockid, label } = args;

            const paymentTypeDropDown = this.domElements().paymenttypes.setter({
                element: this.getVotingPaymentTypes(blockid, label)
            });

            $(e.target.nextElementSibling).replaceWith(paymentTypeDropDown);

        } catch (error) {
            throw new Error(`Failed to replaceDefaultPaymentTypesWithIllicoCachPaymentTypes due this error:${error.message} `);
        }
    }

    getIllicoCashPaymentTypes(e) {
        try {


            if (!e && !e instanceof Event) {
                return;
            }

            const type = e.target.value;

            if (type === "illicocash") {

                this.replaceDefaultPaymentTypesWithIllicoCachPaymentTypes({
                    e,
                    blockid: 630,
                    label: "Illico Cash"
                });
            }

            if (type === "flexpay") {

                this.replaceDefaultPaymentTypesWithIllicoCachPaymentTypes({
                    e,
                    blockid: this.getBlockIdReference(),
                    label: "Mobile Money, Visa"
                });

            }

        } catch (error) {
            throw new Error(`Failed to getIllicoCashPaymentTypes due this error:${error.message}`);
        }
    };

    getPaymentCategoryDropDown(args) {
        try {
            const gen = this.gen();
            const { onchangeCallBack = undefined } = args;

            const categoryArrayObject = this.getPaymentCategoryArrayObject();

            return gen.dropDownFromArray({
                array: categoryArrayObject,
                id: "key",
                output: "title",
                attr: { class: "select-container" },
                css: { marginBottom: "5px" },
                legend: "Selectionner mode de paiement",
                onchange: onchangeCallBack.bind(this)
            });

        } catch (error) {
            throw new Error(`Failed to getPaymentCategoryDropDown due this error:${error.message}`);
        }
    };

    getFlexPayApiUrl() {
        return "sdapp-manager/vendor-frameworks/php/flexpayapi.php";
        //"https://beta-cardpayment.flexpay.cd/v1/pay";
        //"sdapp-manager/vendor-frameworks/php/flexpayapi.php";
    }

    /**
     * Returns the frontendgen property of the window object.
     * @returns {object} The frontendgen property.
     */
    gen() {
        return window.frontendgen;
    };

    /**
     * Returns the API URL for the Illicocash PHP endpoint.
     * @returns {string} The API URL.
     */
    getApiUrl() {
        return "sdapp-manager/vendor-frameworks/php/illicocashapi.php";
    }

    /**
     * Returns an object containing form group IDs and their corresponding getter functions.
     * @returns {object} An object with form group IDs and their getters.
     */
    formGroupIds() {
        const getter = function () {
            return document.getElementById(this.id);
        }

        return {
            notification: {
                id: "sdapp-form-group-notification-id",
                getter
            },
            phonenumber: {
                id: "sdapp-form-group-phonenumber",
                getter
            },
            submitbutton: {
                id: "sdapp-form-group-submitbutton",
                getter
            }
        }
    }

    /**
     * Checks if a given phone number is valid based on predefined regular expression patterns.
     * @param {string} phoneNumber - The phone number to be validated.
     * @returns {boolean} True if the phone number is valid, otherwise false.
     */
    isValidPhoneNumber(phoneNumber) {
        // Regular expression patterns for valid phone numbers
        const patterns = [
            /^\+\d{12}$/,   // +243977660514
            /^0\d{9}$/,     // 0977660514
            /^\d{12}$/      // 243977660514
        ];

        // Test the phone number against the patterns
        return patterns.some((pattern) => pattern.test(phoneNumber));
    }


    /**
     * Retrieves the payment type array by making a server-side request.
     * @returns {object} The payment type array retrieved from the server.
     */
    getPaymentTypeArray(blockId) {
        const gen = this.gen();
        gen.serverSideUrl = window.frontendgen.serverUrl;
        const serverResult = gen.url(false, gen.serverSideUrl, {
            key: 'returnjson',
            datatype: "json",
            table: "sdappdata",
            ref: ` WHERE blockid = '${blockId}' AND datastatus > 0 ORDER BY sdappdataid ASC`,
            getter: true
        }, false, 1);

        return this.gen().getObjectFromJSON(serverResult);
    };

    /**
     * Retrieves the candidate record by making a server-side request using the provided ID.
     * @param {string} id - The ID of the candidate record to retrieve.
     * @returns {object} The candidate record retrieved from the server.
     */
    getCandidateRecord(id) {
        const gen = this.gen();
        gen.serverSideUrl = window.frontendgen.serverUrl;
        const serverResult = gen.url(false, gen.serverSideUrl, {
            key: 'returnjson',
            datatype: "json",
            table: "sdappdata",
            ref: ` WHERE sdappdataid = '${id}' AND datastatus > 0 ORDER BY sdappdataid ASC`,
            getter: true
        }, false, 1);

        return this.gen().getObjectFromJSON(serverResult);
    };

    /**
     * Adds event listeners to form input elements to apply styling when focused.
     */
    displayInputs() {
        const formControls = document.querySelectorAll('.form-control');
        formControls.forEach((input) => {
            input.addEventListener('focus', () => {
                input.classList.add('form-control-border');
            });
            input.addEventListener('blur', () => {
                input.classList.remove('form-control-border');
            });
        });
    }

    /**
     * Retrieves the last value from an array.
     * @param {array} array - The input array.
     * @returns {*} The last value in the array, or undefined if the input is not an array.
     */
    getLastValueFromArray(array) {
        if (Array.isArray(array)) {
            return array[array.length - 1];
        }
    }

    /**
     * Returns the block ID reference value.
     * @returns {number} The block ID reference value.
     */
    getBlockIdReference = () => {
        return 627;
    };

    /**
     * Retrieves the block columns from the server and returns an array of column keys.
     * @returns {array} An array of column keys.
     * @throws {Error} If there is an error getting the block columns.
     */
    getBlockColumns(blockId) {
        const block = this.getBlock(blockId)[0];
        try {
            return this.gen().getObjectFromJSON(block.columnsobjects).map(item => { return item.key; });
        } catch (error) {
            throw new Error(`Failed to get block columns due to this error: ${error}`);
        }
    };

    /**
     * Filters the payment types array using the provided filter function.
     * @param {function} func - The filter function to apply.
     * @returns {array} The filtered payment types array.
     * @throws {Error} If there is an error filtering the payment types.
     */
    filterPaymentTypes(func) {
        const paymentTypes = this.getPaymentTypeArray(this.getBlockIdReference());//this.getPaymentTypeArray();
        try {
            if (typeof func === "function") {
                return paymentTypes.filter(item => { const f = func(item); return f === true; });
            }
            return paymentTypes;
        } catch (error) {
            throw new Error(`Failed to filter payment types due to this error: ${error}`);
        }
    };

    /**
     * Retrieves the block from the server based on the block ID reference.
     * @returns {object} The block object.
     */
    getBlock(blockId) {
        const gen = this.gen();
        gen.serverSideUrl = window.frontendgen.serverUrl;
        const serverResult = gen.url(false, gen.serverSideUrl, {
            key: 'returnjson',
            datatype: "json",
            table: "sdappblockreference",
            ref: `WHERE blockid = '${blockId}' AND datastatus > 0`,
            getter: true
        }, false, 1);
        return this.gen().getObjectFromJSON(serverResult);
    };

    /**
     * Generates a warning element with the provided type and warning message.
     * @param {object} objectArgs - An object containing the type and warning properties.
     * @param {string} objectArgs.type - The type of the warning (e.g., "success", "warning", "danger").
     * @param {string} objectArgs.warning - The warning message.
     * @returns {object} A jQuery object representing the warning element.
     * @throws {Error} If the arguments are invalid.
     */
    warning(objectArgs) {
        const { type, warning } = objectArgs;
        if (!(type && warning)) {
            throw new Error(`Invalid argument`);
        }
        return $(this.gen().createEl("div")).attr({ class: `alert alert-${type}`, role: "alert" }).html(warning);
    }

    /**
         * Parses the phone number and applies a specific setter based on matching patterns.
         * @param {string} phoneNumber - The phone number to parse.
         * @returns {string} The parsed phone number.
         */
    phoneNumberParser(phoneNumber, prefix = "00") {
        const patterns = [
            {
                pattern: /^\+\d{12}$/,
                setter: () => {
                    return `${prefix}${phoneNumber.toString().slice(1)}`;
                }
                // Comment: If the phone number matches the pattern /^\+\d{12}$/, the setter returns a modified version of the phone number.
            },
            {
                pattern: /^0\d{9}$/,
                setter: () => {
                    return `${prefix}243${phoneNumber.toString().slice(1)}`;
                }
                // Comment: If the phone number matches the pattern /^0\d{9}$/, the setter returns a modified version of the phone number.
            },
            {
                pattern: /^\d{12}$/,
                setter: () => {
                    return `${prefix}${phoneNumber}`;
                }
                // Comment: If the phone number matches the pattern /^\d{12}$/, the setter returns a modified version of the phone number.
            }
        ];

        for (const pattern of patterns) {
            if (pattern.pattern.test(phoneNumber)) {
                return pattern.setter();
                // Comment: Returns the result of the setter function for the matching pattern.
            }
        }

        // Return the original phoneNumber if no match is found
        return phoneNumber;
        // Comment: Returns the original phoneNumber when no matching pattern is found.
    };

    /**
    *A modal box functionality.
    *@param {Object} gen - The gen object.
    * @returns {Object} - Returns an object with methods related to the modal box.
    */
    modalBox(gen) {
        /**
         * Represents a collection of elements.
         * @typedef {Object} Elements
         * @property {string} id - The ID of the element.
         * @property {Function} setter - A function to set the element.
         * @property {Function} getter - A function to get the element.
         */

        /**
         * Creates a collection of elements.
         * @returns {Elements} The collection of elements.
         */
        const elements = function () {
            /**
             * Sets an element with the provided CSS class and placeholder.
             * @param {string} element - The element to set.
             * @param {string} cssclass - The CSS class to apply to the element.
             * @param {string} placeholder - The placeholder value for the element.
             * @returns {jQuery} The jQuery object representing the created element.
             */
            const setter = function (element, cssclass, placeholder) {
                return $(gen.createEl(element)).attr({ id: this.id, class: cssclass, placeholder });
            };

            /**
             * Gets the element.
             * @returns {jQuery} The jQuery object representing the element.
             */
            const getter = function () {
                return $(document.getElementById(this.id));
            };

            return {
                modalheader: {
                    id: 'sdapp-illico-cash-api-modal-box-header-id',
                    setter,
                    getter
                },
                modalcontent: {
                    id: 'sdapp-illico-cash-api-modal-box-content-id',
                    setter,
                    getter
                },
                phonenumberinput: {
                    id: `sdapp-illico-cash-api-modal-box-phone-number-input`,
                    setter,
                    getter
                },
                notificationsection: {
                    id: `sdapp-illico-cash-api-modal-box-notification-section`,
                    setter,
                    getter
                },
                otpinput: {
                    id: `sdapp-illico-cash-api-modal-box-otp-input`,
                    setter,
                    getter
                }
            };
        };

        /**
         * Represents the user interface.
         * @typedef {Object} UserInterface
         * @property {Function} gen - A function to generate elements.
         * @property {Function} objectInterfaceMaker - A function to create an object interface.
         * @property {Function} init - A function to initialize the user interface.
         */

        /**
         * Creates the user interface.
         * @returns {UserInterface} The user interface.
         */
        const userInterface = () => {
            return this.gen().objectInterfaceMaker([
                {
                    element: "div",
                    attr: { id: "myModal", class: "_modal" },
                    children: [
                        {
                            element: "div",
                            attr: { class: "_modal-content" },
                            children: [
                                {
                                    element: "span",
                                    attr: { class: "_close" },
                                    html: "&times;"
                                },
                                {
                                    element: elements(this.gen()).modalheader.setter("p"),
                                    // Sets the modal header element using the 'setter' function of the 'elements' object.
                                },
                                {
                                    element: elements(this.gen()).modalcontent.setter("p"),
                                    // Sets the modal content element using the 'setter' function of the 'elements' object.
                                }
                            ]
                        }
                    ]
                }
            ]).init();
        };


        /**
         * Generates a submit button for voting.
         * @param {Object} objectArgs - The arguments for generating the button.
         * @returns {HTMLElement} The generated submit button element.
         */
        const votingSubmitButton = (objectArgs) => {
            return this.gen().anchor({
                icon: "fa fa-question-circle",
                title: "Recevoir code OTP",
                attr: {
                    class: "btn btn-primary"
                },
                css: {
                    marginTop: "5px"
                },
                callback: (e) => {
                    e.preventDefault();
                    confirmVotingPayment(objectArgs);
                }
            });
        };


        /**
         * Performs the confirmation of voting payment.
         * @param {Object} objectArgs - The arguments for confirming the voting payment.
         */
        const confirmVotingPayment = (objectArgs) => {
            // Validate the voting payment confirmation
            if (!confirmVotingPaymentValidation()) {
                return;
            }

            // Get the notification section element
            const notificationSection = elements(this.gen()).notificationsection.getter();

            // Get the phone number input value
            const phoneNumber = elements(this.gen()).phonenumberinput.getter().val();

            // Parse the phone number
            const phoneNumberParsed = this.phoneNumberParser(phoneNumber);

            // Send a request to the API for voting payment confirmation
            this.gen().urlSimple(
                notificationSection,
                this.getApiUrl(),
                {
                    mobilenumber: phoneNumberParsed,
                    amount: objectArgs.pricing,
                    step: "getotp"
                },
                (result, section) => ({
                    /**
                     * Handles the success response from the API.
                     */
                    onsuccess() {
                        $(section).html(confirmVotingPayment1Feedback(result));
                        objectArgs.illicocashpaymentpostresult = result;
                        objectArgs.mobilenumber = phoneNumber;
                        getConfirmVotingPayment2Form(objectArgs);
                    },
                    /**
                     * Handles the 403 response from the API.
                     */
                    on_403() {
                        console.error("error");
                    }
                }),
                "sdapp-manager/img/loading.gif",
                "POST"
            );
        };


        /**
         * Generates the feedback for confirming voting payment based on the result.
         * @param {string} result - The result of the voting payment confirmation.
         * @returns {HTMLElement} The generated feedback element.
         */
        const confirmVotingPayment1Feedback = result => {
            // Convert the result to an object
            result = gen.getObjectFromJSON(result);

            if (typeof result === "object" && result !== null && result.hasOwnProperty("respcodedesc") && result.hasOwnProperty("respcode")) {
                const code = parseInt(result.respcode);
                const warning = result.respcodedesc;

                if (code === 0) {
                    // Return success feedback if code is 0
                    return this.warning({
                        type: "success",
                        warning: "La première étape de votre paiement est approuvée. Veuillez insérer ici le Code OTP qui vous est envoyé par SMS."
                    });
                }

                if (code > 0) {
                    // Return warning feedback if code is greater than 0
                    return this.warning({
                        type: "warning",
                        warning
                    });
                }
            }

            // Return warning feedback for unidentified errors
            return this.warning({
                type: "warning",
                warning: "Erreur non identifiée"
            });
        };


        /**
         * Retrieves the form for the second step of confirming voting payment.
         * @param {Object} objectArgs - The arguments for retrieving the form.
         * @returns {boolean} Returns false.
         */
        const getConfirmVotingPayment2Form = (objectArgs) => {
            let { illicocashpaymentpostresult } = objectArgs;

            // Convert the illicocashpaymentpostresult to an object
            illicocashpaymentpostresult = gen.getObjectFromJSON(illicocashpaymentpostresult);

            // Update the illicocashpaymentpostresult in the objectArgs
            objectArgs.illicocashpaymentpostresult = illicocashpaymentpostresult;

            if (illicocashpaymentpostresult !== null && typeof illicocashpaymentpostresult === "object"
                && illicocashpaymentpostresult.hasOwnProperty("respcode")
                && parseInt(illicocashpaymentpostresult.respcode) < 1) {
                // Replace the form for the second step of payment confirmation
                confirmPaymentStep2FormReplacer(objectArgs);
            }

            return false;
        };

        /**
         * Replaces the form with the second step of payment confirmation.
         * @param {Object} objectArgs - The arguments for replacing the form.
         */
        const confirmPaymentStep2FormReplacer = (objectArgs) => {
            // Get the form group elements
            const fromGroup1 = this.formGroupIds().phonenumber.getter();
            const fromGroup2 = this.formGroupIds().submitbutton.getter();

            // Create the OTP input element
            const otpInput = elements().otpinput.setter("input", "form-control", "Entrer votre code OTP")[0];

            otpInput.type = "text";
            otpInput.style.marginBottom = "5px";

            // Clear the content of the form groups
            fromGroup1.innerHTML = "";
            fromGroup2.innerHTML = "";

            // Append the OTP input element to the first form group
            fromGroup1.appendChild(otpInput);

            // Append the second step button element to the second form group
            fromGroup2.appendChild(confirmPaymentStep2Button(objectArgs)[0]);

            // Display the inputs
            this.displayInputs();

            // Set focus on the OTP input element
            otpInput.focus();
        };


        /**
         * Generates the button for completing the last step of voting payment.
         * @param {Object} objectArgs - The arguments for generating the button.
         * @returns {HTMLElement} The generated button element.
         */
        const confirmPaymentStep2Button = (objectArgs) => {
            return gen.anchor({
                icon: "fas fa-check-circle",
                title: "Terminer la dernière étape pour voter",
                attr: {
                    class: "btn btn-success"
                },
                css: {
                    cursor: "pointer",
                    color: "#fff",
                    width: "100%"
                },
                callback: (e) => {
                    e.preventDefault();
                    confirmPaymentStep2ButtonRequestServerAndTerminatePayment(objectArgs);
                }
            });
        };


        /**
         * Sends a request to the server and terminates the voting payment process by validating the OTP.
         * @param {Object} objectArgs - The arguments for the request and termination.
         */
        const confirmPaymentStep2ButtonRequestServerAndTerminatePayment = (objectArgs) => {
            /**
             * Validates the OTP input.
             * @returns {boolean} Returns true if the OTP input is valid; otherwise, returns false.
             */
            const validateOtp = () => {
                // Get the notification section and OTP input elements
                const notification = elements().notificationsection.getter()[0];
                const otpInput = elements().otpinput.getter()[0];

                // Create a warning element
                const warning = this.warning({
                    type: "warning",
                    warning: "Veuillez entrer le numéro OTP pour terminer le vote!"
                })[0];

                if (otpInput.value.length < 1) {
                    // Display the warning if the OTP input is empty
                    notification.innerHTML = "";
                    notification.appendChild(warning);
                    otpInput.focus();
                    return false;
                }

                return true;
            };

            /**
             * Generates the feedback for terminating the voting payment based on the result.
             * @param {string} result - The result of terminating the voting payment.
             * @param {Object} candidate - The candidate object.
             * @returns {HTMLElement} The generated feedback element.
             */
            const terminatePaymentFeedback = (result, candidate) => {
                // Convert the result to an object
                result = gen.getObjectFromJSON(result);

                if (typeof result === "object" && result.hasOwnProperty("respcodedesc") && result.hasOwnProperty("respcode")) {
                    const code = parseInt(result.respcode);
                    const warning = result.respcodedesc;

                    if (code === 0) {
                        // Return success feedback if code is 0
                        return this.warning({
                            type: "success",
                            warning: `Félicitations ! Vous venez de voter pour votre candidate ${candidate.candidatefullname.toUpperCase()} ! Vous pouvez voter plusieurs fois pour augmenter ses chances de gagner la couronne de Miss Malaika.`
                        });
                    }

                    if (code > 0) {
                        // Return warning feedback if code is greater than 0
                        return this.warning({
                            type: "warning",
                            warning
                        });
                    }
                }

                // Return warning feedback for unidentified errors
                return this.warning({
                    type: "warning",
                    warning: "Erreur non identifiée"
                });
            };

            /**
             * Terminates the voting payment process.
             * @param {Object} objectArgs - The arguments for terminating the payment.
             */
            const terminatePayment = (objectArgs) => {
                const { illicocashpaymentpostresult } = objectArgs;
                const { referencenumber } = illicocashpaymentpostresult;

                const notificationSection = elements(this.gen()).notificationsection.getter();
                const otpInput = elements(this.gen()).otpinput.getter();
                const otp = otpInput.val();
                const data = { step: "terminate", referencenumber, otp };
                const me = this;
                this.gen().urlSimple(
                    notificationSection,
                    this.getApiUrl(),
                    data,
                    (result, section) => ({
                        /**
                         * Handles the success response from the API.
                         */
                        onsuccess() {
                            $(section).html(terminatePaymentFeedback(result, objectArgs));
                            otpInput.val("");
                            me.writeCandidateCounting(objectArgs, result, 1);
                        },
                        /**
                         * Handles the 403 response from the API.
                         */
                        on_403() {
                            console.error("error");
                        }
                    }),
                    "sdapp-manager/img/loading.gif",
                    "GET"
                );
            };

            if (validateOtp()) {
                terminatePayment(objectArgs);
            }
        };


        /**
         * Validates the voting payment confirmation.
         * @returns {boolean} Returns true if the validation passes; otherwise, returns false.
         */
        const confirmVotingPaymentValidation = () => {
            const phoneNumberInput = elements(this.gen()).phonenumberinput.getter();
            const notificationSection = elements(this.gen()).notificationsection.getter();

            if (phoneNumberInput.val().length < 1) {
                // Display a warning if the phone number input is empty
                notificationSection.html(this.warning({
                    type: "warning",
                    warning: "Veuillez ajouter votre numéro illico cash"
                }));
                phoneNumberInput.focus();
                return false;
            }

            if (!this.isValidPhoneNumber(phoneNumberInput.val())) {
                // Display a warning if the phone number input is not valid
                notificationSection.html(this.warning({
                    type: "warning",
                    warning: "Veuillez ajouter un numéro de téléphone valide"
                }));
                phoneNumberInput.focus();
                return false;
            }

            // Clear the notification section
            notificationSection.html("");
            return true;
        };

        /**
         * Generates the voting form with the candidate information.
         * @param {Object} objectArgs - The arguments for generating the form.
         */
        const votingForm = (objectArgs) => {
            const { candidatefullname, pricinglabel, paymentcategory, paymentcategorylabel } = objectArgs;

            // Get the modal header, modal content, and notification section elements
            const modalHeader = elements(this.gen()).modalheader.getter();
            const modalcontent = elements(this.gen()).modalcontent.getter();
            const notificationSection = elements(this.gen()).notificationsection.setter("div");

            // Create the phone number input element
            const phoneNumberInput = elements(this.gen()).phonenumberinput.setter("input", "form-control");
            phoneNumberInput.attr({ placeholder: "Votre numéro illico cash", type: "number" });

            // Generate the submit button
            const submitButton = votingSubmitButton(objectArgs);

            // Set the content of modal header and modal content elements
            modalHeader.html(`Vote pour : ${candidatefullname.bold().toUpperCase()} , Voix : ${pricinglabel} , catégorie : ${paymentcategorylabel.bold().toUpperCase()}`);
            modalcontent.html("");
            modalcontent.append(formGroup(notificationSection, this.formGroupIds().notification.id));

            // Append form groups to modal content
            if (paymentcategory === "illicocash") {
                getIllicoCashForm({ modalcontent, submitButton, notificationSection, phoneNumberInput });
            }
            if (paymentcategory === "flexpay") {
                objectArgs.modalcontent = modalcontent;
                objectArgs.notificationSection = notificationSection
                getFlexPayForm(objectArgs);
            }

        };

        const getFlexPayForm = (args) => {
            try {
                const { modalcontent, notificationSection } = args;
                const pushFormSubmitButton = () => {
                    return gen.anchor({
                        title: "Lancer le push sur votre téléphone et entrer le mot de passe",
                        icon: "fa fa-bell",
                        attr: { class: "btn btn-primary" },
                        css: { width: "100%", color: "#fff", marginTop: "5px" },
                        callback: (e) => {
                            triggerFlexPayPush(e, args);
                        }
                    });
                };

                const flexPayMobileMoneyForm = () => {

                    const clientPhoneNumber = this.domElements().flexpayclientphonenumber.setter({
                        element: "input",
                        attr: {
                            type: "number",
                            class: "form-control",
                            placeholder: "Entrer votre numéro de téléphone"
                        },
                        css: {
                            marginBottom: "5px"
                        }
                    });

                    return this.gen().objectInterfaceMaker([
                        {
                            element: "div",
                            attr: {
                                class: "col-lg-12"
                            },
                            html: clientPhoneNumber
                        },
                        {
                            element: "div",
                            attr: {
                                class: "col-lg-12"
                            },
                            html: pushFormSubmitButton()
                        }
                    ]).init();
                };

                const flexPayCardForm = () => {
                    const generateFormInIframe = () => {
                        const data = {
                            authorization: "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJcL2xvZ2luIiwicm9sZXMiOlsiTUVSQ0hBTlQiXSwiZXhwIjoxNzUzMjkwOTA2LCJzdWIiOiJlNDM1MzNjM2U4YWE5N2ZhZGNiMzUzZTU0NWE3YmM4MyJ9.cDErAAblnOlxC2ZNHSGaOHu2K5Lg167yWgW-UDzh8nE",
                            merchant: "OZZONE",
                            reference: this.gen().generateReferenceCode(8),
                            amount: "100",
                            currency: "USD",
                            description: "Miss Malaika Vote",
                            callback_url: "page-eca-flex-pay-callback-url",
                            approve_url: "page-ecb-flexpay-approve-url",
                            cancel_url: "page-ecc-flex-url-cancel-url",
                            decline_url: "page-ecd-flex-pay-decline-url"
                        };

                        const formHTML = `
                          <form action="https://beta-cardpayment.flexpay.cd/v1/pay" method="post" id="payment-form">
                            <input type="text" name="authorization" placeholder="authorization" value="${data.authorization}" /><br>
                            <input type="text" name="merchant" placeholder="merchant" value="${data.merchant}" /><br>
                            <input type="text" name="reference" placeholder="reference" value="${data.reference}" /><br>
                            <input type="text" name="amount" placeholder="amount" value="${data.amount}" /><br>
                            <input type="text" name="currency" placeholder="currency" value ="${data.currency}" /><br>
                            <input type="text" name="description" placeholder="description" value="${data.description}" /><br>
                            <input type="text" name="callback_url" placeholder="callback_url" value="${data.callback_url}" /><br>
                            <input type="text" name="approve_url" placeholder="approve_url" value="${data.approve_url}" /><br>
                            <input type="text" name="cancel_url" placeholder="cancel_url" value="${data.cancel_url}" /><br>
                            <input type="text" name="decline_url" placeholder="decline_url" value="${data.decline_url}" /><br>
                            <input type="submit" value="Envoyer" />
                          </form>
                        `;


                        const iframe = document.createElement("iframe");

                        // Adjust the iframe properties if needed
                        iframe.style.width = "400px";
                        iframe.style.height = "500px";
                        iframe.style.border = "none"; // Removing border


                        // Set the iframe content to the formHTML
                        iframe.srcdoc = formHTML;

                        // Append the iframe to the container
                        return formHTML;//iframe;
                    };
                    return "waiting the process is loading...";
                };

                const submitCardForm = async () => {
                    const data = {
                        authorization: "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJcL2xvZ2luIiwicm9sZXMiOlsiTUVSQ0hBTlQiXSwiZXhwIjoxNzUzMjkwOTA2LCJzdWIiOiJlNDM1MzNjM2U4YWE5N2ZhZGNiMzUzZTU0NWE3YmM4MyJ9.cDErAAblnOlxC2ZNHSGaOHu2K5Lg167yWgW-UDzh8nE",
                        merchant: "OZZONE",
                        reference: this.gen().generateReferenceCode(8),
                        amount: "100",
                        currency: "USD",
                        description: "Miss Malaika Vote",
                        callback_url: "page-eca-flex-pay-callback-url",
                        approve_url: "page-ecb-flexpay-approve-url",
                        cancel_url: "page-ecc-flex-url-cancel-url",
                        decline_url: "page-ecd-flex-pay-decline-url"
                    };

                    try {
                        const response = await fetch('https://beta-cardpayment.flexpay.cd/v1/pay', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify(data)
                        });

                        if (!response.ok) {
                            // Handle API error responses
                            console.error(response);
                            return;
                        }

                        console.log("Payment successful");

                        // Additional processing after successful payment
                    } catch (error) {
                        // Handle network or other errors
                        console.error(error.message);
                    }
                };

                const flexPayPaymentTypes = (e) => {

                    const type = parseInt(e.target.value);
                    const flexPayDynamicFormSection = $(this.domElements().flexpaydynamicformsection.getter());

                    if (type === 1) {
                        flexPayDynamicFormSection.html(flexPayMobileMoneyForm())
                    }

                    if (type === 2) {
                        flexPayDynamicFormSection.html(flexPayCardForm());
                        submitCardForm();
                    }
                };

                const pushForm = () => {

                    const mobilemoneyPaymentCategory1 = this.domElements().mobilepaymentradiobutton1.setter({
                        element: "input",
                        attr: {
                            type: "radio",
                            name: "fleypay-payment-category",
                            value: 1,
                            checked: true
                        }
                    });

                    const mobilemoneyPaymentCategory2 = this.domElements().mobilepaymentradiobutton1.setter({
                        element: "input",
                        attr: {
                            type: "radio",
                            value: 2
                        }
                    });

                    const flexPayDynamicFormSection = this.domElements().flexpaydynamicformsection.setter({
                        element: "div"
                    });

                    const interfaceObject = gen.objectInterfaceMaker([
                        {
                            element: "div",
                            attr: {
                                class: "row"
                            },
                            children: [
                                {
                                    element: "div",
                                    attr: {
                                        class: "col-lg-6"
                                    },
                                    css: {
                                        marginBottom: "5px"
                                    },
                                    children: [
                                        {
                                            element: mobilemoneyPaymentCategory1,
                                            on: {
                                                type: "click",
                                                callback: (e) => {
                                                    flexPayPaymentTypes(e);
                                                }
                                            }
                                        },
                                        {
                                            element: "label",
                                            attr: {
                                                for: "Paiement mobile"
                                            },
                                            css: {
                                                marginLeft: "5px"
                                            },
                                            html: "Paiement mobile"
                                        }
                                    ]
                                },
                                {
                                    element: "div",
                                    attr: {
                                        class: "col-lg-6"
                                    },
                                    css: {
                                        marginBottom: "5px"
                                    },
                                    children: [
                                        {
                                            element: mobilemoneyPaymentCategory2,
                                            on: {
                                                type: "click",
                                                callback: (e) => {
                                                    flexPayPaymentTypes(e);
                                                }
                                            }
                                        },
                                        {
                                            element: "label",
                                            attr: {
                                                for: "Paiement carte"
                                            },
                                            css: {
                                                marginLeft: "5px"
                                            },
                                            html: "Paiement carte"
                                        }
                                    ]
                                },
                                {
                                    element: flexPayDynamicFormSection,
                                    html: flexPayMobileMoneyForm()
                                }
                            ]
                        }
                    ]).init();

                    const form = this.domElements().flexpaypushform.setter({ element: "div" });
                    form.html(interfaceObject);
                    return form;
                };



                const triggerFlexPayPush = (e, args) => {
                    try {
                        if (!e && !e instanceof Event) {

                            return;
                        }

                        e.preventDefault();
                        const clientPhoneNumber = this.domElements().flexpayclientphonenumber.getter();

                        if (clientPhoneNumber[0].value.length < 1) {
                            notificationSection.html(this.warning({ type: "warning", warning: "Veuillez entrer votre numéro de téléphone Airtel money, ou Mpsa ou Orange Money" }));
                            clientPhoneNumber[0].focus();
                            return false;
                        }

                        if (!this.isValidPhoneNumber(clientPhoneNumber.val())) {
                            // Display a warning if the phone number input is not valid
                            notificationSection.html(this.warning({
                                type: "warning",
                                warning: "Veuillez ajouter un numéro de téléphone valide"
                            }));
                            clientPhoneNumber[0].focus();
                            return false;
                        }

                        //notificationSection.html(generateFormInIframe())
                        const data = {
                            amount: args.pricing,
                            phonenumber: this.phoneNumberParser(clientPhoneNumber[0].value, ""),
                            currency: "usd"
                        };

                        const clearPushForm = () => {
                            this.domElements().flexpaypushform.getter().html("");
                        };

                        const getTransactionLog = (orderNumber) => {
                            // An array of tasks to perform sequentially.
                            const taskObjectArray = [
                                {
                                    type: "phpnative",
                                    implementation: {
                                        function: "file_get_contents",
                                        arguments: ["../../sdapp-manager/vendor-frameworks/php/flexpay_callback_log.txt"]
                                    }
                                },
                                {
                                    type: "phpnative",
                                    implementation: {
                                        function: "json_decode",
                                        arguments: ["@result", true] // Decode JSON data from a string.
                                    }
                                }
                            ];

                            // Execute the sequence of server tasks and return the result.
                            const result = this.gen().executeConsecutiveServerTasks(taskObjectArray, this.gen().serverSideUrl);
                            if (Array.isArray(result) && result.length > 0) {
                                for (const row of result) {
                                    const elementRow = this.gen().getObjectFromJSON(row);
                                    if (elementRow.orderNumber === orderNumber) {
                                        return elementRow;
                                    }
                                }
                            }
                        };

                        const processTransactionConfirmation = (transactionObject, lastPendingTransaction) => {

                            const getLastTransaction = () => {

                                if (lastPendingTransaction.hasOwnProperty("data")
                                    && lastPendingTransaction.data.hasOwnProperty("votecounting")
                                    && Array.isArray(lastPendingTransaction.data.votecounting)
                                    && lastPendingTransaction.data.votecounting.length > 0) {
                                    const newArray = [];
                                    for (const element of lastPendingTransaction.data.votecounting) {
                                        if (
                                            Array.isArray(element) && element.length > 0 &&
                                            element[0].referencenumber !== undefined &&
                                            transactionObject.orderNumber !== undefined &&
                                            transactionObject.orderNumber.toString().toLowerCase() === element[0].referencenumber.toString().toLowerCase()
                                        ) {
                                            element[0].pending = false;
                                        }
                                        newArray.push(element);
                                    }

                                    lastPendingTransaction.data.votecounting = newArray;
                                    return lastPendingTransaction;

                                }
                            };

                            if (transactionObject.code === "0" || parseInt(transactionObject.code) === 0) {
                                this.updateCandidateRecord(getLastTransaction());
                                console.log("success");
                            }
                            else {
                                console.log("failure");
                            }
                        }

                        const confirmPush = (serverResult, section, mobilenumber) => {
                            const result = gen.getObjectFromJSON(serverResult);
                            if (parseInt(result.code) === 0) {
                                section.html(this.warning({ type: "success", warning: result.message }));
                                clearPushForm();
                                args.mobilenumber = mobilenumber;
                                args.illicocashpaymentpostresult = { referencenumber: result.orderNumber };
                                const lastPendingTranslation = this.writeCandidateCounting(args, serverResult, 2, false);
                                setTimeout(() => {
                                    const transactionLog = getTransactionLog(result.orderNumber);
                                    if (transactionLog !== undefined && typeof transactionLog === "object") {
                                        //process transaction confirmation starts
                                        processTransactionConfirmation(transactionLog, lastPendingTranslation);
                                        //process transaction confirmation ends
                                    }
                                }, 0.5 * 60 * 1000); // 3 minutes in milliseconds

                                return;
                            }

                            if (parseInt(result.code) === 1) {
                                section.html(this.warning({ type: "warning", warning: result.message }));
                                return;
                            }


                        }

                        this.gen().urlSimple(
                            notificationSection,
                            this.getFlexPayApiUrl(),
                            data,
                            (result, section) => ({
                                /**
                                 * Handles the success response from the API.
                                 */
                                onsuccess() {
                                    confirmPush(result, section, data.phonenumber);
                                },
                                /**
                                 * Handles the 403 response from the API.
                                 */
                                on_403() {
                                    console.error("error");
                                }
                            }),
                            "sdapp-manager/img/loading.gif",
                            "POST"
                        );


                    } catch (error) {
                        throw new Error(`Failed to testFlexPayApi due this error:${error.message}`);
                    }
                }
                modalcontent.append(pushForm());

            } catch (error) {
                throw new Error(`Failed to getFlexPayForm due this error:${error.message}`);
            }
        };
        const getIllicoCashForm = (args) => {
            try {

                const { modalcontent, submitButton, phoneNumberInput } = args;
                modalcontent.append(formGroup(phoneNumberInput, this.formGroupIds().phonenumber.id));
                modalcontent.append(formGroup(submitButton, this.formGroupIds().submitbutton.id));

            } catch (error) {
                throw new Error(`Failed to getIllicoCashForm due this error:${error.message} `);
            }
        };

        /**
         * Generates a form group element with the specified element and ID.
         * @param {HTMLElement} element - The element to be wrapped in the form group.
         * @param {string} id - The ID attribute of the form group.
         * @returns {HTMLElement} The generated form group element.
         */
        const formGroup = (element, id) => {
            return $(this.gen().createEl("div")).attr({ class: "form-group", id }).html(element);
        };

        /**
         * Displays the modal on the page.
         */
        const displayModal = () => {
            const modal = document.getElementById("myModal");
            modal.style.display = "block";
        };

        /**
         * Opens the modal with the voting form and displays inputs.
         * @param {Object} objectArgs - The arguments for opening the modal.
         */
        const openModal = (objectArgs) => {
            votingForm(objectArgs);
            displayModal();
            this.displayInputs();
        };

        /**
         * Closes the modal and hides it from the page.
         * @param {Object} objectArgs - The arguments for closing the modal.
         */
        const closeModal = (objectArgs) => {
            const closeBtn = document.getElementsByClassName("_close")[0];

            /**
             * Function to close the modal and hide it from the page.
             */
            const func = () => {
                const modal = document.getElementById("myModal");
                modal.style.display = "none";
            };

            if (typeof objectArgs === "object" && objectArgs.hasOwnProperty("trigger") && objectArgs.hasOwnProperty("timeout")) {
                const { timeout } = objectArgs;

                // Set a timeout to close the modal after the specified timeout
                setTimeout(() => { func(); }, timeout);
            }

            // Add an event listener to the close button to close the modal
            if (closeBtn) {
                closeBtn.addEventListener("click", func);
            }

        };

        /**
         * Applies custom CSS styles for the modal box and form controls.
         */
        const style = () => {
            const cssCode = `
        <style>
            /* Modal Box Styles */
            ._modal {
                display: none;
                /* Hide the modal by default */
                position: fixed;
                /* Fixed position */
                z-index: 1;
                /* Sit on top */
                left: 0;
                top: 0;
                width: 100%;
                /* Full width */
                height: 100%;
                /* Full height */
                overflow: auto;
                /* Enable scrolling if needed */
                background-color: rgba(0, 0, 0, 0.5);
                /* Black background with transparency */
            }
            
            ._modal-content {
                background-color: #fefefe;
                margin: 15% auto;
                /* 15% from the top and centered */
                padding: 20px;
                border: 1px solid #888;
                width: 80%;
                /* 80% width */
            }
            
            ._close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }
            
            ._close:hover,
            ._close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }
            
            /* Custom CSS for form controls */
            .form-control-border {
                border: 1px solid #ced4da !important;
            }
            
            input.form-control,
            textarea.form-control {
                border: 1px solid #ced4da;
            }
            
            input.form-control:focus,
            textarea.form-control:focus {
                border-color: #ced4da;
                box-shadow: none;
            }
            
            /* Additional Custom CSS */
            .container-with-shadow {
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
                padding: 20px;
                border-radius: 5px;
            }
            
            .btn.btn-primary {
                width: 100%;
                padding: 10px;
            }
        </style>
    `;
            $(`head`).append(cssCode);
        };

        /**
         * Returns an object containing the exported functions.
         * @returns {Object} An object with the exported functions.
         */
        return {
            /**
             * Generates the user interface.
             */
            userInterface,

            /**
             * Opens the modal with the voting form and displays inputs.
             * @param {Object} objectArgs - The arguments for opening the modal.
             */
            openModal,

            /**
             * Closes the modal and hides it from the page.
             * @param {Object} objectArgs - The arguments for closing the modal.
             */
            closeModal,

            /**
             * Applies custom CSS styles for the modal box and form controls.
             */
            style
        };

    }



    /**
    * Updates the candidate record with new data.
    * @param {Object} objectArgs - The arguments for updating the candidate record.
    * @returns {Promise} A promise that resolves after the candidate record is updated.
    */
    updateCandidateRecord(objectArgs) {
        const { data, candidateid } = objectArgs;

        return this.gen().url(
            false,
            this.gen().serverSideUrl,
            {
                key: 'sqledit',
                table: 'sdappdata',
                fieldandvalues: {
                    data
                },
                referencefield: "sdappdataid",
                referenceid: candidateid
            },
            false,
            1
        );
    };

    /**
    * Writes the candidate counting based on the result of the voting payment.
    * @param {Object} objectArgs - The arguments for writing the candidate counting.
    * @param {string} result - The result of the voting payment.
    */
    writeCandidateCounting(objectArgs, result, type, closeModal = true) {

        const getCodeValue = (type, result) => {
            if (type === 1) {
                return result.respcode; // illicocahs
            }

            if (type === 2) {
                return result.code; // flexpay
            }

        }

        const pendingTransaction = (type) => {
            if (type === 2) {
                return true;
            }
        };

        result = this.gen().getObjectFromJSON(result);

        if (type === 1 && !(typeof result === "object" && result.hasOwnProperty("respcodedesc") && result.hasOwnProperty("respcode"))) {
            // If the result is not in the expected format, return
            return;
        }

        if (type === 2 && !(typeof result === "object" && result.hasOwnProperty("code") && result.hasOwnProperty("message"))) {
            // If the result is not in the expected format, return
            return;
        }

        const code = parseInt(getCodeValue(type, result));

        if (code > 0) {
            // If the code is greater than 0, return
            return;
        }

        const { pricinglabel, candidatefullname, candidateid, pricing, illicocashpaymentpostresult = {}, mobilenumber } = objectArgs;
        const { referencenumber } = illicocashpaymentpostresult;
        const blockColumns = this.getBlockColumns(this.getBlockIdReference());
        const voiceColumn = blockColumns[3];
        const amountColumn = blockColumns[1];

        /**
         * A filtering function to find the payment type with matching amount.
         * @param {Object} item - The payment item to filter.
         * @returns {boolean} Returns true if the amount matches; otherwise, returns false.
         */
        const func = (item) => {
            const dataParsed = this.gen().getObjectFromJSON(item.data);
            return parseInt(dataParsed[amountColumn]) === parseInt(pricing);
        };

        const resultFiltered = this.filterPaymentTypes(func);
        const voice = resultFiltered.length > 0 ? parseInt(this.gen().getObjectFromJSON(resultFiltered[0].data)[voiceColumn]) : undefined;
        const candidateRecord = this.getCandidateRecord(candidateid);
        const candidateData = candidateRecord.length ? this.gen().getObjectFromJSON(candidateRecord[0].data) : {};
        const newData = [
            {
                voice,
                candidatefullname,
                candidateid,
                pricing,
                referencenumber,
                pricinglabel,
                votermobilenumber: mobilenumber,
                date: this.gen().getCurrentDate(),
                time: this.gen().getCurrentTimes(),
                pending: pendingTransaction(type)
            }
        ];

        if (typeof candidateData === "object" && candidateData.hasOwnProperty("votecounting")) {
            // If candidateData has votecounting property, push the new data
            candidateData.votecounting.push(newData);
        } else {
            // If candidateData doesn't have votecounting property, initialize it
            candidateData.votecounting = newData;
        }

        // Update the candidate record with the new data
        this.updateCandidateRecord({
            data: candidateData,
            candidateid
        });


        if (closeModal) {
            // Close the modal box
            this.modalBox(this.gen()).closeModal({
                trigger: true,
                timeout: 1000
            });
        }


        return {
            data: candidateData,
            candidateid
        };
    };





    /**
    Initializes the Miss Malaika page.
    @method missMalaika
    @memberof ClassName
    @description This method sets up the Miss Malaika page by performing various tasks such as retrieving candidate information,
    creating the user interface elements, handling voting functionality, and appending payment types to each candidate section.
    It also appends a modal user interface to the latest candidate section and applies styling to the modal box. Finally, it closes
    the modal box.
    */
    missMalaika() {

        /**
         * The gen object from the frontendgen window.
         */
        const gen = this.gen();

        /**
         * The server-side URL from the frontendgen serverUrl property.
         */
        gen.serverSideUrl = window.frontendgen.serverUrl;

        /**
         * The main attribute used to identify candidate elements.
         */
        const mainAttribute = 'integrate-illico-cash-payment-api';

        /**
         * Selects all the div elements that have the specified attribute.
         */
        const candidateReference = document.querySelectorAll(`div[${mainAttribute}]`);


        /**
         * Retrieves the first candidate ID from the candidateReference elements.
         * @returns {number} The first candidate ID.
         * @throws {Error} If failed to get the candidate ID.
         */
        const getFirstCandidateId = () => {
            try {
                return parseInt(candidateReference[0].getAttribute(mainAttribute));
            } catch (error) {
                throw new Error(`Failed to get the candidate ID due to this error: ${error}`);
            }
        };

        /**
         * Retrieves the last candidate section from the candidateReference elements.
         * @returns {HTMLElement} The last candidate section.
         * @throws {Error} If failed to get the last candidate section.
         */
        const getLastCandidateSection = () => {
            try {
                return this.getLastValueFromArray(Array.from(candidateReference));
            } catch (error) {
                throw new Error(`Failed to get the last candidate section due to this error: ${error}`);
            }
        };

        /**
         * Appends the modal user interface to the latest candidate section.
         */
        const appendModalUserInterfaceToTheLatestCandidateSection = () => {
            const parentDiv = $(gen.createEl("div")).html(this.modalBox(gen).userInterface()[0]);
            $(getLastCandidateSection()).after(parentDiv);
        };






        /**
         * Generates a voting button as an anchor element.
         * @returns {HTMLElement} The generated voting button.
         */
        const votingButton = () => {
            return gen.anchor({
                icon: "fa fa-thumbs-up",
                title: "&nbsp;&nbsp; Voter",
                attr: { class: "btn btn-primary" },
                css: {
                    color: "#fff",
                    display: "flex",
                    marginTop: "10px",
                    marginLeft: "auto",
                    marginRight: "auto",
                    justifyContent: "center", /* Aligns items horizontally at the center */
                    alignItems: "center", /* Aligns items vertically at the center */
                    width: "58%"
                },
                callback: (e) => {
                    e.preventDefault();
                    voteNowWithIllicoCash(e);
                }
            });
        };


        /**
         * Handles the voting process with Illico Cash.
         * @param {Event} event - The event object triggered by the voting button.
         */
        const voteNowWithIllicoCash = (event) => {
            // Find the closest parent div with the main attribute
            const parentDiv = event.target.closest(`div[${mainAttribute}]`);

            // Retrieve the candidate ID and candidate full name from the parent div
            const candidateId = parentDiv.getAttribute(mainAttribute);
            const candidateFullname = parentDiv.getAttribute('candidate-fullname');

            const votingPaymentCategory = parentDiv.querySelector(`select[name="voting-pricing-categories"]`);
            const paymentCategoryLabel = $(votingPaymentCategory).children('option:selected').html();

            // Retrieve the voting pricing select element and its selected option
            const votingPrincing = parentDiv.querySelector(`select[name="voting-pricing"]`);
            const pricingLabel = $(votingPrincing).children('option:selected').html();
            const pricing = votingPrincing.value;

            if (votingPaymentCategory.value.length < 1) {
                alert("Veuillez selectionner la catégorie de paiement");
                votingPaymentCategory.focus();
                return false;
            }

            // Validate the selected pricing
            if (pricing < 1) {
                alert("Veuillez sélectionner une voix pour voter");
                votingPrincing.focus();
                return false;
            }

            // Open the modal box with the relevant information
            this.modalBox(gen).openModal({
                candidateid: candidateId,
                candidatefullname: candidateFullname,
                pricinglabel: pricingLabel,
                pricing,
                paymentcategory: votingPaymentCategory.value,
                paymentcategorylabel: paymentCategoryLabel
            });
        };


        /**
         * Appends the voting payment type and voting button to each candidate section.
        */
        const appendPaymentTypeOnEachCandidate = () => {
            // Retrieve the outer HTML of the voting payment type dropdown list

            const DefaultPaymentTypeDropDown = this.domElements().paymenttypes.setter({
                element: this.getVotingPaymentTypes(this.getBlockIdReference(), "*")
            });
            const paymentType = DefaultPaymentTypeDropDown[0].outerHTML;

            // Iterate over each candidate section
            for (const candidateSection of candidateReference) {

                const paymentCategoryDropDown = this.getPaymentCategoryDropDown({ onchangeCallBack: this.getIllicoCashPaymentTypes });
                const paymentCategoryElement = this.domElements().paymentcategories.setter({ element: paymentCategoryDropDown });

                $(candidateSection).append(paymentCategoryElement);

                // Append the voting payment type dropdown list to the candidate section
                $(candidateSection).append(paymentType);

                // Append the voting button to the candidate section
                $(candidateSection).append(votingButton());
            }
        };

        const getCandidateVotingResult = () => {
            const gen = this.gen();
            const serverUrl = window.frontendgen.serverUrl;
            const getUserSessionsAndUnsetSession = () => {
                try {
                    const serverResult = gen.url(
                        false,
                        serverUrl,
                        {
                            key: 'getusersessions',
                            getter: true
                        },
                        false,
                        1
                    );


                    return gen.getObjectFromJSON(serverResult);
                } catch (error) {
                    throw new Error(`Failed to getUserSession due this error:${error.message}`);
                }
            };
            const getUserId = () => {
                try {
                    const userSessions = getUserSessionsAndUnsetSession();
                    if (!userSessions) {
                        return;
                    }
                    if (userSessions !== null
                        && typeof userSessions === "object"
                        && userSessions.hasOwnProperty("SDAPP-AUTO-LOGIN-USER-INFO")
                        && userSessions["SDAPP-AUTO-LOGIN-USER-INFO"] !== null
                        && typeof userSessions["SDAPP-AUTO-LOGIN-USER-INFO"] === "object"
                        && userSessions["SDAPP-AUTO-LOGIN-USER-INFO"].hasOwnProperty("user-id")
                    ) {
                        return parseInt(userSessions["SDAPP-AUTO-LOGIN-USER-INFO"]["user-id"]);
                    }
                } catch (error) {
                    throw new Error(`Failed to getUserId due this error:${error.message}`);
                }
            };
            const getUserData = () => {
                try {
                    const userRecord = this.getCandidateRecord(getUserId());
                    return this.gen().getObjectFromJSON(userRecord[0].data);
                } catch (error) {
                    throw new Error(`Failed to getUserData due this error:${error.message}`);
                }
            }
            const mergePaymentTypes = () => {
                try {
                    const flex = this.getPaymentTypeArray(this.getBlockIdReference());
                    const illicoCash = this.getPaymentTypeArray(630);
                    if (!Array.isArray(flex) || flex.length < 1 || !Array.isArray(illicoCash) || illicoCash.length < 1) {
                        return;
                    }
                    return flex.concat(illicoCash).map(item => { return this.gen().getObjectFromJSON(item.data); });
                }
                catch (error) {
                    throw new Error(`Failed to mergePaymentTypes due this error:${error.message}`);
                }
            };
            const showCandidateVotes = () => {
                try {
                    const voteSection = document.querySelector(`p[missmalaikacandidatevoteresult="true"]`);
                    if (!voteSection) {
                        return;
                    }

                    const data = getUserData();
                    const theadrows = [
                        {
                            html: "No"
                        },
                        {
                            html: "Date"
                        },
                        {
                            html: "Heure"
                        },
                        {
                            html: "No Réf"
                        },
                        {
                            html: "No Votant"
                        },
                        {
                            html: "Montant"
                        },
                        {
                            html: "Nbre Vote",
                            css: { textAlign: "right" }
                        },
                        {
                            html: "Status"
                        }
                    ];
                    const tbodyrows = data.hasOwnProperty("votecounting") ? getTbodyRowsCandidateVotes(data.votecounting) : [];
                    //const  tableattributes;
                    const table = this.gen().tableMaker({ theadrows, tbodyrows });


                    $(voteSection).html(table);
                } catch (error) {
                    throw new Error(`Failed to showCandidateVotes due this error:${error.message}`);
                }
            };
            const getTbodyRowsCandidateVotes = (votes) => {

                const validateTrueVoices = (item) => {
                    if (item.hasOwnProperty("pending") && [false, "false"].includes(item.pending)) {
                        return true;
                    }

                    if (item.hasOwnProperty("pending") && [true, "true"].includes(item.pending)) {
                        return false;
                    }

                    return true;
                }

                const voiceStatus = (item) => {
                    if (item.hasOwnProperty("pending") && [false, "false"].includes(item.pending)) {
                        return "Confimé";
                    }

                    if (item.hasOwnProperty("pending") && [true, "true"].includes(item.pending)) {
                        return "En attente"
                    }

                    return "Confirmé"
                }
                try {
                    if (!votes || !Array.isArray(votes) || votes.length < 1) {
                        return;
                    }
                    const rows = [];
                    const nA = "NA";
                    let n = 0;
                    let voteTotal = 0;
                    for (let item of votes) {
                        n++;
                        if (Array.isArray(item) && item.length > 0) {
                            item = item[0];
                        }
                        let numberOfVote = item.pricing ? getVoiceNumber(item.pricing) : 0;
                        if (numberOfVote !== null && typeof numberOfVote === "object" && "1181_counting" in numberOfVote) {
                            numberOfVote = parseInt(numberOfVote["1181_counting"]);
                        }

                        if (validateTrueVoices(item)) {
                            voteTotal += numberOfVote;
                        }

                        rows.push([
                            {
                                html: n
                            },
                            {
                                html: item.date ? this.gen().frDate(item.date) : nA
                            },
                            {
                                html: item.time ? item.time : nA
                            },
                            {
                                html: item.referencenumber ? item.referencenumber : nA
                            },
                            {
                                html: item.votermobilenumber ? item.votermobilenumber : nA
                            },
                            {
                                html: item.pricing ? `${item.pricing} USD` : nA
                            },
                            {
                                html: numberOfVote,
                                css: { textAlign: "right" }
                            },
                            {
                                html: voiceStatus(item)
                            }
                        ]);
                    }
                    rows.push([
                        {
                            html: "<b>TOTAL</b>"
                        },
                        {
                            html: `<strong>${voteTotal}</strong>`,
                            attr: { colspan: 6 },
                            css: { textAlign: "right" }
                        }
                    ]);
                    return rows;
                } catch (error) {
                    throw new Error(`Failed to getTbodyRowsCandidateVotes due this error:${error.message}`);
                }
            }
            const getVoiceNumber = (amount) => {
                try {
                    if (!amount || amount < 1) {
                        return;
                    }
                    amount = parseFloat(amount);
                    return mergePaymentTypes().find(item => { return parseFloat(item["1068_montant"]) === amount });
                } catch (error) {
                    throw new Error(`Failed to getVoiceNumber due this error:${error.message}`);
                }
            };
            showCandidateVotes();
            mergePaymentTypes();
        };

        /**
        * Appends the voting payment type and voting button to each candidate section.
        */
        appendPaymentTypeOnEachCandidate();

        /**
         * Appends the modal user interface to the latest candidate section.
         */
        appendModalUserInterfaceToTheLatestCandidateSection();

        getCandidateVotingResult();

        /**
         * Adds custom styles for the modal box.
         */
        this.modalBox(gen).style();

        /**
         * Closes the modal box.
         */
        this.modalBox(gen).closeModal();



    }

    executer(method) {
        // Check if the specified method exists as a function
        if (typeof this[method] === "function") {
            // Call the specified method
            this[method]();
        } else {
            console.error("Method not found.");
        }
    }
    /**
     * Runs a specified method when the DOM content is loaded.
     * @param {string} method - The name of the method to run.
     */
    run(method, runImmediately) {
        if (runImmediately) {
            this.executer(method)
            return;
        }
        // Add an event listener for the DOMContentLoaded event
        document.addEventListener('DOMContentLoaded', () => {
            this.executer(method);
        });
    }


}

/**
 * Create a new instance of IllicoCash and run the specified method.
 */
new IllicoCash(window.frontend).run("missMalaika");







