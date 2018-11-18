<!---
The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
--->


<cfscript>
param url.format = "html";

string function getMyDir () output="false" {

	param url.path = "/"; // must end with slash

	var myDirs = directoryList(expandPath(".") & url.path, false, "query");

	var arDir = [];

	// show link to parent
	if (url.path != "/")	{
		arDir.append ({
			"name"		: "Parent",
			"path"		: url.path.reverse().listrest("/").reverse() & "/",
			"makeLink"	: "dir",
			"size"		: "",
			"type"		: "dir",
			"icon"		: "folder-open",
			"iconPack"	: "fas",
			"iconType"	: "",
			"modified"	: ""	
		});
	}

	for (var myDir in myDirs) {
		var stData = {
			"name" 		: myDir.name,
			"href" 		: myDir.type == "file" ? url.path & myDir.name : "?path=" & url.path & myDir.name & "/",
			"path"		: myDir.type == "file" ? "" : url.path & myDir.name & "/",
			"makeLink"	: lcase(myDir.type),
			"size" 		: myDir.type == "dir" ? "" : myDir.size > 1024 ? myDir.size \ 1024 & " KB" : myDir.size & " bytes",
			"type" 		: myDir.type,
			"icon" 		: myDir.type == "File" ? "file" : "folder",
			"iconPack"	: "fas",
			"iconType" 	: "",
			"modified" 	: LSDateFormat(myDir.DateLastModified) & " @ " & LSTimeFormat(myDir.DateLastModified)
		};


		if (myDir.type == "File" && left(myDir.name, 1) == ".")	{
			stData.type = "Hidden File";
			stData.iconType = "is-warning";
			stData.makeLink = "none";
		}


		if (myDir.type == "Dir" && left(myDir.name, 1) == ".")	{
			stData.type = "Hidden Directory";
			stData.iconType = "is-warning";
			stData.makeLink = "none";
		}


		switch (myDir.name) {
			case "CFIDE" :
			case "cf_scripts" :
			case "WEB-INF" :
			stData.type = "System Directory";
			stData.iconType = "is-danger";
			stData.makeLink = "none";
			break;

			case "Test" :
			stData.type = "Test Directory";
			stData.iconType = "is-success";
			stData.makeLink = "none";
			break;
		}

		// tried to make colors match Visual Studio Code
		var arFileTypes = [
			"cfc" 		: { type : "ColdFusion Component", icon : "code", 	iconType : "is-primary",						makeLink : "none"},
			"cfm" 		: { type : "ColdFusion Template", 	icon : "code"},
			"cfml" 		: { type : "ColdFusion Template", 	icon : "code"},
			"css" 		: { type : "Cascading Style Sheet",	icon : "css3",	iconType : "is-info", 		iconPack : "fab" },
			"db" 		: { type : "Useless Windows File",	icon : "frown",											makeLink : "none" },
			"ds_store" 	: { type : "Useless MacOS File",	icon : "frown",											makeLink : "none" },
			"gif" 		: { type : "GIF Image", 			icon : "image", 	iconType : "is-primary" },
			"git" 		: { type : "GIT", 				icon : "git-square",iconType : "is-danger", 		iconPack : "fab" },
			"gitignore" 	: { type : "GIT Ignore", 		icon : "git-square",iconType : "is-danger", 		iconPack : "fab" },
			"htm" 		: { type : "Static HTML File", 	icon : "code",		iconType : "is-warning" },
			"html" 		: { type : "Static HTML File", 	icon : "code",		iconType : "is-warning" },
			"ico" 		: { type : "Icon", 				icon : "image", 	iconType : "is-primary" },
			"jpg" 		: { type : "JPEG Image", 		icon : "image", 	iconType : "is-primary" },
			"jpeg" 		: { type : "JPEG Image", 		icon : "image", 	iconType : "is-primary" },
			"js" 		: { type : "JavaScript File",		icon : "js", 								iconPack : "fab", 	makeLink : "none" },
			"json" 		: { type : "JSON Data File",		icon : "js", 								iconPack : "fab" },
			"md" 		: { type : "Markdown File",		icon : "markdown", 	iconType : "is-info", 		iconPack : "fab" },
			"pdf" 		: { type : "Portable Network Graphics", icon : "pdf", 	iconType : "is-danger" 	},
			"pumpkin"		: { type : "Happy Halloween", 	icon : "skull",	iconType : "is-warning" 	}, // pumpkin is not free
			"svg" 		: { type : "SVG Image",			icon : "image", 	iconType : "is-primary" 	},
			"png" 		: { type : "PNG Image", 			icon : "image", 	iconType : "is-primary" 	},
			"txt" 		: { type : "Text File", 			icon : "file-alt" },
			"xml" 		: { type : "XML Data File", 		icon : "code",		iconType : "is-success" 	},
			"zip" 		: { type : "ZIP Archive", 		icon : "file-archive" }
			];

		var ext = listlast(myDir.name, ".");

		if (arFileTypes.keyExists(ext))	{
			stData.append(arFileTypes[ext], true);
		}


		arDir.append(stData);
	} // end for

	return serializeJSON(arDir);
} // end function

if(url.format == "JSON")	{

	cfheader(name="Content-Type", value="application/json");
	cfsetting(showDebugOutput = false);
	writeOutput(getMyDir());
	exit;
	}
</cfscript>



<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>ColdFusion Landing Page</title>

	<link rel="stylesheet" href="https://unpkg.com/buefy/dist/buefy.min.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" crossorigin="anonymous">

	<script src="https://unpkg.com/vue@2.5.17"></script>
	<script src="https://unpkg.com/buefy@0.6.7"></script>
	<script src="https://unpkg.com/axios@0.18.0/dist/axios.min.js"></script>

</head>
<body>

	<div id="app">

	<section class="hero is-info">
		<div class="hero-body">
			<div class="container">
				<h1 class="title">
					ColdFusion Landing Page
				</h1>
				<h2 class="subtitle">
					By James Mohler
				</h2>
			</div>
		</div>
	</section>


	<section class="section">
		<div class="container">
		
			<div class="columns">
				<div class="column is-four-fifths">
					<h1 class="title">
						Directory Listing for <code>{{path}}</code>
					</h1>
				</div>
				<div class="column">
					<button class="button is-primary" @click="getDir">
						<b-icon pack="fas" icon="sync" size="is-small"></b-icon>
						<span>Refresh</span>
					</button>
				</div>
			</div>


			<b-table :data="myDir" :loading="loading">
				<template slot-scope="props">
					<b-table-column field="icon">
						<b-icon :pack="props.row.iconPack" :icon="props.row.icon" :type="props.row.iconType"></b-icon>
					</b-table-column>

					<b-table-column field="name" label="Name">
						<a		v-if="props.row.makeLink == 'file'" :href="props.row.href">{{ props.row.name }}</a>
						<a		v-if="props.row.makeLink == 'dir'" @click="path=props.row.path">{{ props.row.name }}</a>
						<span	v-if="props.row.makeLink == 'none'">{{ props.row.name }}</span>
					</b-table-column>

					<b-table-column field="size" label="Size" numeric>
						{{ props.row.size }}
					</b-table-column>

					<b-table-column field="type" label="Type">
						{{ props.row.type }}
					</b-table-column>

					<b-table-column field="modified" label="Modified">
						{{ props.row.modified }}
					</b-table-column>
				</template>
			</b-table>

		</div><!--/ container -->
	</section>

	<section class="section">
		<div class="container">

			<div class="columns">
				<div class="column is-four-fifths">
					<h1 class="title">
						System Configuration
					</h1>
				</div>
				<div class="column">
					<a href="/CFIDE/administrator/index.cfm" class="button is-primary">CF Admin</a>
				</div>
			</div>

			<cfoutput>
			<p>
				Product:	
				#server.coldfusion.productname#
				<b>#server.coldfusion.productversion#</b>
				#server.coldfusion.productlevel#
			</p>

			<p>
				OS:	
				#server.os.name#
				<b>#server.os.version#</b>
				(#server.os.arch#)
			</p>

			<p>Installation: <code>#server.coldfusion.rootdir#</code></p>
			</cfoutput>

		</div>
	</section>

	<section class="section">
		<div class="container">
			<div class="columns">
				<div class="column">
					<h1 class="title">ColdFusion Resources</h1>
					<ul>
						<li><a href="https://www.adobe.com/products/coldfusion-family.html">Adobe ColdFusion</a></li>
						<li><a href="https://tracker.adobe.com/">Adobe Issue Tracker</a></li>
						<li><a href="https://coldfusion.adobe.com/">Offical Blog</a></li>
						<li><a href="https://stackoverflow.com/questions/tagged/coldfusion">Stackoverflow: ColdFusion</a></li>
					</ul>
				</div>

				<div class="column">
					<h1 class="title">More Technology Resources</h1>
					<p>All of these are used on this page</p>
					<ul>
						<li><a href="https://buefy.github.io/">Buetify</a></li>
						<li><a href="https://vuejs.org/">VueJS</a></li>
						<li><a href="https://github.com/axios/axios/">Axios</a></li>
						<li><a href="https://bulma.io/">Bulma</a></li>
						<li><a href="https://github.com/">Github</a></li>
					</ul>
				</div>

				<div class="column">
					<h1 class="title">About the Author</h1>

					<p>James Mohler, that's me!</p>
					<ul>
						<li>ColdFusion.Adobe.com: <a href="https://coldfusion.adobe.com/profile/jamesmohler">https://coldfusion.adobe.com/profile/jamesmohler</a></li>
						<li>GitHub: <a href="https://github.com/jmohler1970">https://github.com/jmohler1970</a></li>
						<li>Stackoverflow: <a href="https://stackoverflow.com/users/1845869/james-a-mohler">https://stackoverflow.com/users/1845869/james-a-mohler</a></li>
					</ul>
				</div>
			</div>
		</div><!--/ container -->
	</section>

	</div><!--- /end VueJS --->

	<script>
		new Vue({
			el: '#app',
			data () { 
				return {
					loading : false,
					path  : "/",
					myDir : []
				}
			},

			watch: {
				path: function () {
					this.getDir();
				}
			},

			mounted () {
				this.getDir();
			},

			methods: {
				getDir : function()	{
					console.log("Loading " + this.path);
					this.loading = true;
					axios
						.get('?path=' + this.path + '&format=json')
						.then(response => (this.myDir = response.data))
						.catch(error => {
							console.log(error)
							});
					this.loading = false;
				}
			}
		});
	</script>

</body>
</html>