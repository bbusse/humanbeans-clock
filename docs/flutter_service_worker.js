'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "canvaskit/canvaskit.js": "687636ce014616f8b829c44074231939",
"canvaskit/canvaskit.wasm": "d4972dbefe733345d4eabb87d17fcb5f",
"canvaskit/profiling/canvaskit.js": "ba8aac0ba37d0bfa3c9a5f77c761b88b",
"canvaskit/profiling/canvaskit.wasm": "05ad694fda6cfca3f9bbac4b18358f93",
"flutter.js": "195f32f4217e034162a6697208586f44",
"main.dart.js": "bf7dc073faf2c2c526ecc714631bb4bb",
"version.json": "84e563f834d355b342253e81a019a88d",
"assets/assets/rive/Bird_Final_2.flr": "8e1cb304f1f11d982ab84127bbd60e47",
"assets/assets/rive/Light_Final.flr": "65e9bb5d46460df44287f4f4bf236f95",
"assets/assets/images/Pngs_Flat_0003_Bird_Shine_Color_Dodge.png": "f08c07f638ee97a3fa7b7fbe0ad53b1f",
"assets/assets/images/Pngs_Flat_0002_Texture_Multiply.png": "ad30cedb81b9b58486e70cb9cf07eb2f",
"assets/assets/images/Pngs_Flat_0007_F_B_Left.png": "77fc06081fa563bdb7e6339329cc114d",
"assets/assets/images/Pngs_Flat_0008_F_B_Left_2.png": "6b9041e73899690b3489ab58a29834c2",
"assets/assets/images/Pngs_Flat_0004_F_Leaf_L_1.png": "a1d1ab092ec622647acacec8adcb6d25",
"assets/assets/images/Pngs_Flat_0005_F_Leaf_L_2.png": "c54aec3885e949fd26cd01fd9a182cf8",
"assets/assets/images/Pngs_Flat_0006_F_Leaf_L_3.png": "e237550934fa59b983081b9ad6f36083",
"assets/assets/images/Pngs_Flat_0033_B_Br_Left.png": "aef1dba59b9c7b80776e65fc2b1993d5",
"assets/assets/images/Pngs_Flat_0034_B_Br_Left_1.png": "9a1720d6c70fed057189a2548a395950",
"assets/assets/images/Pngs_Flat_0032_B_Leaf_L_1.png": "a165063024c86b11c19ba357f30f1f56",
"assets/assets/images/Pngs_Flat_0031_B_Leaf_L_2.png": "d9d6ec42d90a8cf17136eafb21dceec7",
"assets/assets/images/Pngs_Flat_0030_B_Leaf_L_3.png": "97aabb34cfd1e4481a303f31f69bde4b",
"assets/assets/images/Pngs_Flat_0029_B_leaf_L_4.png": "55b6f447a8e6dedeea5f226961ef0d7f",
"assets/assets/images/Pngs_Flat_0028_B_Leaf_L_5.png": "29976256a2ae7e115ce536a72ae2b5cb",
"assets/assets/images/Pngs_Flat_0027_B_Leaf_L_6.png": "c1bb306610431b159453520190ff7f6e",
"assets/assets/images/Pngs_Flat_0001_Texture_Screen.png": "18961246533819ab5eb815d72c4303ba",
"assets/assets/images/Pngs_Flat_0014_F_B_Right.png": "41fa14b45f252683db903bbc7fd2ebc2",
"assets/assets/images/Pngs_Flat_0015_F_B_Right_2.png": "684aaaf05cf92490160df448b087bf04",
"assets/assets/images/Pngs_Flat_0013_F_Leaf_R_5.png": "63bf0082273bba26cd23a4e7c5ad3491",
"assets/assets/images/Pngs_Flat_0012_F_Leaf_R_4.png": "39a845a35d1613da51ed4b1cb54d3be7",
"assets/assets/images/Pngs_Flat_0011_F_Leaf_R_3.png": "8da1605fc477ce12e74447b7b7c807b8",
"assets/assets/images/Pngs_Flat_0010_F_Leaf_R_2.png": "2e6dabb911b0f120bdac011aa0ee05aa",
"assets/assets/images/Pngs_Flat_0009_F_Leaf_R_1.png": "348277c20f9365d457bd8ce863c81398",
"assets/assets/images/Pngs_Flat_0022_B_Leaf_R_5.png": "5b09573d93b612cb218e23fd35d55472",
"assets/assets/images/Pngs_Flat_0035_B_Br_right.png": "4fd4bc4cc50549dc3c71fdc9bcda254d",
"assets/assets/images/Pngs_Flat_0036_B_Br_Right_1.png": "bf18c6a996d091076848a84c9543e031",
"assets/assets/images/Pngs_Flat_0037_B_Br_right_2.png": "76d4c8266191badd13a6bc6524ed6819",
"assets/assets/images/Loading_Screen.png": "c65fbd754cdbbac2002b6ab576afebea",
"assets/assets/images/Pngs_Flat_0023_B_Leaf_R_4.png": "40307811cedd8cc50b3c5472610f855c",
"assets/assets/images/Pngs_Flat_0024_B_Leaf_R_3.png": "3c742cbe9715048033f8b0881fd1c3b5",
"assets/assets/images/Pngs_Flat_0026_B_Leaf_R_1.png": "1d7ece900fd804f710db748dd43d2c05",
"assets/assets/images/Pngs_Flat_0025_B_Leaf_R_2.png": "84df0da35a0df855758cb176cb827670",
"assets/assets/images/Dots.png": "880ddbf57c61445fbb0668eb0f72c8c3",
"assets/assets/fonts/Bird_font.ttf": "866ad3c726574a721f1c703669cd488b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/shaders/ink_sparkle.frag": "a04e492a05f9fd1a8cc6f12163b184dd",
"assets/AssetManifest.json": "51684493c9bff4cdb61f7b464538535f",
"assets/FontManifest.json": "45325e6d3a2678923c37565a1bba9d09",
"assets/NOTICES": "82dcf9c4e0665e7009a75f9754f222d9",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "f56bf3295ede2ef3514b106c5218a0b3",
"/": "f56bf3295ede2ef3514b106c5218a0b3",
"manifest.json": "b82c3fcbb434381201e3ef2430994b42"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
