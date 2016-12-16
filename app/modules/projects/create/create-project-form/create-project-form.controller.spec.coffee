###
# Copyright (C) 2014-2015 Taiga Agile LLC <taiga@taiga.io>
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
# File: create-project-form.controller.spec.coffee
###

describe.only "CreateProjectFormCtrl", ->
    $provide = null
    $controller = null
    mocks = {}

    _mockCurrentUserService = ->
        mocks.currentUserService = {
            canCreatePublicProjects: sinon.stub(),
            canCreatePrivateProjects: sinon.stub()
        }

        $provide.value("tgCurrentUserService", mocks.currentUserService)

    _mockProjectsService = ->
        mocks.projectsService = {
            create: sinon.stub()
        }

        $provide.value("tgProjectsService", mocks.projectsService)

    _mockProjectUrl = ->
        mocks.projectUrl = {
            get: sinon.stub()
        }

        $provide.value("$projectUrl", mocks.projectUrl)

    _mockLocation = ->
        mocks.location = {
            url: sinon.stub()
        }

        $provide.value("$location", mocks.location)

    _mocks = ->
        module (_$provide_) ->
            $provide = _$provide_

            _mockCurrentUserService()
            _mockProjectsService()
            _mockProjectUrl()
            _mockLocation()

            return null

    _inject = ->
        inject (_$controller_) ->
            $controller = _$controller_

    _setup = ->
        _mocks()
        _inject()

    beforeEach ->
        module "taigaProjects"

        _setup()

    it "submit project form", () ->
        ctrl = $controller("CreateProjectFormCtrl")

        ctrl.projectForm = 'form'

        mocks.projectsService.create.withArgs('form').promise().resolve('project1')
        mocks.projectUrl.get.returns('project-url')

        ctrl.submit().then () ->
            expect(ctrl.submiting).to.be.true

            expect(mocks.location.url).to.have.been.calledWith('project-url')