###
# Copyright (C) 2014-2016 Taiga Agile LLC <taiga@taiga.io>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# File: select-import-user-lightbox.directive.coffee
###

SelectImportUserLightboxDirective = (lightboxService, lightboxKeyboardNavigationService) ->
    link = (scope, el, attrs, ctrl) ->
        scope.$watch 'vm.visible', (visible) ->
            if visible && !el.hasClass('open')
                ctrl.start()
                lightboxService.open(el, scope.vm.onClose).then ->
                    el.find('input').focus()
                    lightboxKeyboardNavigationService.init(el)
            else if !visible && el.hasClass('open')
                lightboxService.close(el)

    return {
        controller: "SelectImportUserLightboxCtrl",
        controllerAs: "vm",
        bindToController: true,
        scope: {
            visible: '<',
            onClose: '&',
            onSelectUser: '&',
            user: '<'
        },
        templateUrl: 'projects/create/select-import-user-lightbox/select-import-user-lightbox.html'
        link: link
    }

SelectImportUserLightboxDirective.$inject = ['lightboxService', 'lightboxKeyboardNavigationService']

angular.module("taigaProjects").directive("tgSelectImportUserLightbox", SelectImportUserLightboxDirective)