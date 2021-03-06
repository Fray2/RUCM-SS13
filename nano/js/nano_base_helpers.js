// NanoBaseHelpers is where the base template helpers (common to all templates) are stored
NanoBaseHelpers = function ()
{
	var _baseHelpers = {
            // change ui styling to "specific modes"
			xenoMode: function() {
				$('body').css("background-color","#1B1E25");
				$('body').css("background-image","url('uiBackground-Xeno.png')");
				$('body').css("background-position","50% 0");
				$('body').css("background-repeat","repeat-x");

				$('#uiTitleFluff').css("background-image","url('uiTitleFluff-Xeno.png')");
				$('#uiTitleFluff').css("background-position","50% 50%");
				$('#uiTitleFluff').css("background-repeat", "no-repeat");

				return '';
			},
			predMode: function() {
				$('body').css("background-color","#23221f");
				$('body').css("background-image","url('uiBackground-Pred.png')");
				$('body').css("background-position","50% 0");
				$('body').css("background-repeat","repeat-x");

				$('#uiTitleFluff').css("background-image","url('uiTitleFluff-Pred.png')");
				$('#uiTitleFluff').css("background-position","20% 20%");
				$('#uiTitleFluff').css("background-repeat", "no-repeat");

				return '';
			},
			USCMMode: function() {
				$('body').css("background-color","#0C0E1E");
				$('body').css("background-image","url('uiBackground-USCM.png')");
				$('body').css("background-position","50% 0");
				$('body').css("background-repeat","repeat-x");

				$('#uiTitleFluff').css("background-image","url('uiTitleFluff-USCM.png')");
				$('#uiTitleFluff').css("background-position","20% 20%");
				$('#uiTitleFluff').css("background-repeat", "no-repeat");

				return '';
			},
			UPPMode: function() {
				$('body').css("background-color","#242721");
				$('body').css("background-image","url('uiBackground-UPP.png')");
				$('body').css("background-position","50% 0");
				$('body').css("background-repeat","repeat-x");

				$('#uiTitleFluff').css("background-image","url('uiTitleFluff-UPP.png')");
				$('#uiTitleFluff').css("background-position","20% 20%");
				$('#uiTitleFluff').css("background-repeat", "no-repeat");

				return '';

			},
			CLFMode: function() {
				$('body').css("background-color","#443232");
				$('body').css("background-image","url('uiBackground-CLF.png')");
				$('body').css("background-position","50% 0");
				$('body').css("background-repeat","repeat-x");

				$('#uiTitleFluff').css("background-image","url('uiTitleFluff-CLF.png')");
				$('#uiTitleFluff').css("background-position","20% 20%");
				$('#uiTitleFluff').css("background-repeat", "no-repeat");

				return '';
			},
			// Generate a Byond link
			link: function( text, icon, parameters, status, elementClass, elementId) {

				var iconHtml = '';
				var iconClass = 'noIcon';
				if (typeof icon != 'undefined' && icon)
				{
					iconHtml = '<div class="uiLinkPendingIcon"></div><div class="uiIcon16 icon-' + icon + '"></div>';
					iconClass = 'hasIcon';
				}

				if (typeof elementClass == 'undefined' || !elementClass)
				{
					elementClass = 'link';
				}

				var elementIdHtml = '';
				if (typeof elementId != 'undefined' && elementId)
				{
					elementIdHtml = 'id="' + elementId + '"';
				}

				if (typeof status != 'undefined' && status)
				{
					return '<div unselectable="on" class="link ' + iconClass + ' ' + elementClass + ' ' + status + '" ' + elementIdHtml + '>' + iconHtml + text + '</div>';
				}

				return '<div unselectable="on" class="linkActive ' + iconClass + ' ' + elementClass + '" data-href="' + NanoUtility.generateHref(parameters) + '" ' + elementIdHtml + '>' + iconHtml + text + '</div>';
			},
			// Insert an icon
			icon: function(icon, elementClass) {
				var iconHtml = '';
				var iconClass = 'noIcon';
				if (typeof icon != 'undefined' && icon)
				{
					iconHtml = '<div class="uiLinkPendingIcon"></div><div class="uiIcon16 icon-' + icon + ' ' + elementClass + '"></div>';
					iconClass = 'hasIcon';
				}

				return iconHtml;
			},
			// Round a number to the nearest integer
			round: function(number) {
				return Math.round(number);
			},
			// Round a number down to integer
			floor: function(number) {
				return Math.floor(number);
			},
			// Round a number up to integer
			ceil: function(number) {
				return Math.ceil(number);
			},
			// Format a string (~string("Hello {0}, how are {1}?", 'Martin', 'you') becomes "Hello Martin, how are you?")
			string: function() {
				if (arguments.length == 0)
				{
					return '';
				}
				else if (arguments.length == 1)
				{
					return arguments[0];
				}
				else if (arguments.length > 1)
				{
					stringArgs = [];
					for (var i = 1; i < arguments.length; i++)
					{
						stringArgs.push(arguments[i]);
					}
					return arguments[0].format(stringArgs);
				}
				return '';
			},
			formatNumber: function(x) {
				// From http://stackoverflow.com/questions/2901102/how-to-print-a-number-with-commas-as-thousands-separators-in-javascript
				var parts = x.toString().split(".");
				parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				return parts.join(".");
			},
			// Display a bar. Used to show health, capacity, etc.
			displayBar: function(value, rangeMin, rangeMax, styleClass, showText) {

				if (rangeMin < rangeMax)
                {
                    if (value < rangeMin)
                    {
                        value = rangeMin;
                    }
                    else if (value > rangeMax)
                    {
                        value = rangeMax;
                    }
                }
                else
                {
                    if (value > rangeMin)
                    {
                        value = rangeMin;
                    }
                    else if (value < rangeMax)
                    {
                        value = rangeMax;
                    }
                }

				if (typeof styleClass == 'undefined' || !styleClass)
				{
					styleClass = '';
				}

				if (typeof showText == 'undefined' || !showText)
				{
					showText = '';
				}

				var percentage = Math.round((value - rangeMin) / (rangeMax - rangeMin) * 100);

				return '<div class="displayBar ' + styleClass + '"><div class="displayBarFill ' + styleClass + '" style="width: ' + percentage + '%;"></div><div class="displayBarText ' + styleClass + '">' + showText + '</div></div>';
			},
			// Display DNA Blocks (for the DNA Modifier UI)
			displayDNABlocks: function(dnaString, selectedBlock, selectedSubblock, blockSize, paramKey) {
			    if (!dnaString)
				{
					return '<div class="notice">Please place a valid subject into the DNA modifier.</div>';
				}

				var characters = dnaString.split('');

                var html = '<div class="dnaBlock"><div class="link dnaBlockNumber">1</div>';
                var block = 1;
                var subblock = 1;
                for (index in characters)
                {
					if (!characters.hasOwnProperty(index) || typeof characters[index] === 'object')
					{
						continue;
					}

					var parameters;
					if (paramKey.toUpperCase() == 'UI')
					{
						parameters = { 'selectUIBlock' : block, 'selectUISubblock' : subblock };
					}
					else
					{
						parameters = { 'selectSEBlock' : block, 'selectSESubblock' : subblock };
					}

                    var status = 'linkActive';
                    if (block == selectedBlock && subblock == selectedSubblock)
                    {
                        status = 'selected';
                    }

                    html += '<div class="link ' + status + ' dnaSubBlock" data-href="' + NanoUtility.generateHref(parameters) + '" id="dnaBlock' + index + '">' + characters[index] + '</div>'

                    index++;
                    if (index % blockSize == 0 && index < characters.length)
                    {
						block++;
                        subblock = 1;
                        html += '</div><div class="dnaBlock"><div class="link dnaBlockNumber">' + block + '</div>';
                    }
                    else
                    {
                        subblock++;
                    }
                }

                html += '</div>';

				return html;
			}
		};
		
	return {
        addHelpers: function ()
		{
            NanoTemplate.addHelpers(_baseHelpers);
        },
		removeHelpers: function ()
		{
			for (var helperKey in _baseHelpers)
			{
				if (_baseHelpers.hasOwnProperty(helperKey))
				{
					NanoTemplate.removeHelper(helperKey);
				}
			}            
        }
	};
} ();
 






