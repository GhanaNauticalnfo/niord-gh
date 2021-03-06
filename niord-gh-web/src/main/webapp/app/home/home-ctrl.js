/*
 * Copyright 2016 Danish Maritime Authority.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * The home controller
 */
angular.module('niord.home')
    .controller('HomeCtrl', ['$scope', '$rootScope', '$timeout', '$stateParams', 'MessageService', 'VersionService',
        function ($scope, $rootScope, $timeout, $stateParams, MessageService, VersionService) {
            'use strict';
            $scope.verifiedMessagesList = [];
            $scope.messageList = [];
            $scope.serverBuildVersion = undefined;
            $scope.webBuildVersion = '${timestamp}';
            $scope.isEditor = $rootScope.hasRole('editor');
            $scope.isAdmin = $rootScope.hasRole('admin');
            var audio = new Audio('audio/got-it-done.mp3');
            // audio.play();
            $scope.init = function () {

                // Load the published messages
                MessageService.search('')
                    .success(function (result) {
                        $scope.messageList.length = 0;
                        for (var x = 0; x < result.data.length; x++) {
                            $scope.messageList.push(result.data[x]);
                        }
                        $scope.totalMessageNo = result.total;
                    });

                if($scope.isAdmin || $scope.isEditor){
                    // Load the verified message lists that need to be published
                    MessageService.search('&status=VERIFIED')
                        .success(function (result) {
                            $scope.verifiedMessagesList.length = 0;
                            for (var x = 0; x < result.data.length; x++) {
                                $scope.verifiedMessagesList.push(result.data[x]);
                            }
                            $scope.totalVerifiedMessageNo = result.total;
                            if(result.total>0 ) {
                                audio.play();
                            }
                        });
                }

                // Load the back-end build version
                VersionService.buildVersion()
                    .success(function (version) {
                        $scope.serverBuildVersion = version;
                    });


                // If specified in the URL, show the given message details
                if ($stateParams.messageId) {
                    $timeout(function() { MessageService.detailsDialog($stateParams.messageId) });
                }
            };


            /** Checks for version conflicts between web and server back-end **/
            $scope.versionConflict = function () {
                return $scope.serverBuildVersion !== undefined &&
                    $scope.webBuildVersion.indexOf('timestamp') === -1 && // When developing - don't show error
                    $scope.serverBuildVersion !== $scope.webBuildVersion;
            }

        }]);
