openapi: 3.0.3
info:
  title: selc-external-api
  description: This service acts as an orchestrator for information coming from different services and as a proxy
  version: 0.0.1-SNAPSHOT
servers:
  - url: 'https://${host}/${basePath}'
tags:
  - name: institutions
    description: Institution Controller
  - name: product
    description: Product Controller
paths:
  '/institutions/byGeoTaxonomies':
    get:
      tags:
        - institutions
      summary: getInstitutionsByGeoTaxonomies
      description: The service retrieves all the institutions based on given a list of geotax ids and a searchMode
      operationId: getInstitutionsByGeoTaxonomiesUsingGET
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - name: geoTaxonomies
          in: query
          description: Geotaxonomy's internal Id
          required: true
          style: form
          explode: true
          schema:
            type: string
        - name: searchMode
          in: query
          description: Searching mode to find institutions based on geotax
          required: false
          style: form
          schema:
            type: string
            enum:
              - all
              - any
              - exact
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/InstitutionDetailResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  '/institutions/{institutionId}/geographicTaxonomy':
    get:
      tags:
        - institutions
      summary: getInstitutionGeographicTaxonomies
      description: The service retrieve the institution's geographic taxonomy
      operationId: getInstitutionGeographicTaxonomiesUsingGET
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - name: institutionId
          in: path
          description: Institution's unique internal Id
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                type: array
                items:
                $ref: '#/components/schemas/GeographicTaxonomyResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  '/institutions':
    get:
      tags:
        - institutions
      summary: getInstitutions
      description: The service retrieves all the onboarded institutions related to the logged user
      operationId: getInstitutionsUsingGET
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - name: productId
          in: query
          description: Product's unique identifier
          required: true
          style: form
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/InstitutionResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  '/institutions/{institutionId}/products/{productId}/users':
      get:
        tags:
          - institutions
        summary: getInstitutionProductUsers
        description: Service to get all the active users related to a specific pair of institution-product
        operationId: getInstitutionProductUsersUsingGET
        parameters:
          - name: x-selfcare-uid
            in: header
            description: Logged user's unique identifier
            required: true
            schema:
              type: string
          - name: institutionId
            in: path
            description: Institution's unique internal identifier
            required: true
            style: simple
            schema:
              type: string
          - name: productId
            in: path
            description: Product's unique identifier
            required: true
            style: simple
            schema:
              type: string
          - name: userId
            in: query
            description: User's unique identifier
            required: false
            style: form
            schema:
              type: string
          - name: productRoles
            in: query
            description: User's roles in product
            required: false
            style: form
            schema:
              type: array
              items:
                type: string
            explode: false
        responses:
          '200':
            description: OK
            content:
              application/json:
                schema:
                  type: array
                  items:
                    $ref: '#/components/schemas/UserResource'
          '400':
            description: Bad Request
            content:
              application/problem+json:
                schema:
                  $ref: '#/components/schemas/Problem'
          '401':
            description: Unauthorized
            content:
              application/problem+json:
                schema:
                  $ref: '#/components/schemas/Problem'
          '404':
            description: Not Found
            content:
              application/problem+json:
                schema:
                  $ref: '#/components/schemas/Problem'
          '500':
            description: Internal Server Error
            content:
              application/problem+json:
                schema:
                  $ref: '#/components/schemas/Problem'
        security:
          - bearerAuth:
              - global
  '/institutions/{institutionId}/products':
    get:
      tags:
        - institutions
      summary: getInstitutionUserProducts
      description: Service to retrieve all active products for given institution and logged user
      operationId: getInstitutionUserProductsUsingGET
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - name: institutionId
          in: path
          description: Institution's unique internal Id
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/ProductResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  '/institutions/{id}':
    get:
      security: [ { } ]
      tags:
        - institutions
      summary: Gets the corresponding institution using internal institution id
      description: Gets institution using internal institution id
      operationId: getInstitution
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - name: id
          in: path
          description: The internal identifier of the institution
          required: true
          schema:
            type: string
            format: uuid
      responses:
        '200':
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Institution'
        '400':
          description: Invalid id supplied
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
  '/user-groups':
    get:
      tags:
      - user-group
      summary: getUserGroups
      description: Service that allows to get a list of UserGroup entities
      operationId: getUserGroupsUsingGET
      parameters:
      - name: x-selfcare-uid
        in: header
        description: Logged user's unique identifier
        required: true
        schema:
          type: string
      - name: institutionId
        in: query
        description: Users group's institutionId
        required: false
        style: form
        schema:
          type: string
      - name: page
        in: query
        description: The page number to access (0 indexed, defaults to 0)
        required: false
        style: form
        allowReserved: true
        schema:
          type: integer
          format: int32
      - name: size
        in: query
        description: Number of records per page (defaults to 20, max 2000)
        required: false
        style: form
        allowReserved: true
        schema:
          type: integer
          format: int32
      - name: sort
        in: query
        description: 'Sorting criteria in the format: property(,asc|desc). Default sort order is ascending. Multiple sort criteria are supported.'
        required: false
        style: form
        allowReserved: true
        schema:
          type: array
          items:
            type: string
      - name: productId
        in: query
        description: Users group's productId
        required: false
        style: form
        schema:
          type: string
      - name: userId
        in: query
        description: Member's unique identifier
        required: false
        style: form
        schema:
          type: string
          format: uuid
      - name: status
        in: query
        description: If filter on status is present, it must be used with at least
          one of the other filters
        required: false
        style: form
        schema:
          type: string
          enum:
          - ACTIVE
          - SUSPENDED
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                "$ref": "#/components/schemas/PageOfUserGroupResource"
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                "$ref": "#/components/schemas/Problem"
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                "$ref": "#/components/schemas/Problem"
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                "$ref": "#/components/schemas/Problem"
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                "$ref": "#/components/schemas/Problem"
      security:
      - bearerAuth:
        - global
  '/products/{productId}':
    get:
      tags:
        - product
      summary: getProduct
      description: The service retrieves Product information from product id
      operationId: getProductUsingGET
      parameters:
        - name: x-selfcare-uid
          in: header
          description: Logged user's unique identifier
          required: true
          schema:
            type: string
        - name: productId
          in: path
          description: Product's unique identifier
          required: true
          style: simple
          schema:
            type: string
        - name: institutionType
          in: query
          description: Institution's type
          required: false
          style: form
          schema:
            type: string
            enum:
              - GSP
              - PA
              - PSP
              - PT
              - SCP
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProductResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
components:
  schemas:
    GeographicTaxonomyResource:
      title: GeographicTaxonomyResource
      required:
        - code
        - desc
      type: object
      properties:
        code:
         type: string
         description: Institution's geographic taxonomy ISTAT code
        desc:
         type: string
         description: Institution's geographic taxonomy extended name
    InstitutionDetailResource:
      title: InstitutionDetailResource
      required:
        - address
        - description
        - digitalAddress
        - externalId
        - geographicTaxonomies
        - id
        - institutionType
        - origin
        - originId
        - taxCode
        - zipCode
      type: object
      properties:
        address:
          type: string
          description: Institution's physical address
        businessRegisterPlace:
          type: string
          description: Institution's business register place
        description:
          type: string
          description: Institution's legal name
        digitalAddress:
          type: string
          description: Institution's digitalAddress
        externalId:
          type: string
          description: Institution's unique external identifier
        geographicTaxonomies:
          type: array
          description: Institution's geographic taxonomy list
          items:
            $ref: '#/components/schemas/GeographicTaxonomyResource'
        id:
          type: string
          description: Institution's unique internal Id
          format: uuid
        imported:
          type: boolean
          description: True if institution is stored from batch api
          example: false
        institutionType:
          type: string
          description: Institution's type
          enum:
            - GSP
            - PA
            - PSP
            - PT
            - SCP
        origin:
          type: string
          description: Institution data origin
        originId:
          type: string
          description: Institution's details origin Id
        rea:
          type: string
          description: Institution's REA
        shareCapital:
          type: string
          description: Institution's share capital value
        supportEmail:
          type: string
          description: Institution's support email contact
          format: email
          example: email@example.com
        supportPhone:
          type: string
          description: Institution's support phone contact
        taxCode:
          type: string
          description: Institution's taxCode
        zipCode:
          type: string
          description: Institution's zipCode
    InstitutionResource:
      title: InstitutionResource
      required:
        - address
        - description
        - digitalAddress
        - externalId
        - id
        - institutionType
        - origin
        - originId
        - status
        - taxCode
        - userProductRoles
        - zipCode
      type: object
      properties:
        address:
          type: string
          description: Institution's physical address
        assistanceContacts:
          description: Institution's assistance contacts
          $ref: '#/components/schemas/AssistanceContactsResource'
        companyInformations:
          description: GPS, SCP, PT optional data
          $ref: '#/components/schemas/CompanyInformationsResource'
        description:
          type: string
          description: Institution's legal name
        digitalAddress:
          type: string
          description: Institution's digitalAddress
        dpoData:
          description: Data Protection Officer (DPO) specific data
          $ref: '#/components/schemas/DpoDataResource'
        externalId:
          type: string
          description: Institution's unique external identifier
        id:
          type: string
          description: Institution's unique internal Id
          format: uuid
        institutionType:
          type: string
          description: Institution's type
          enum:
            - GSP
            - PA
            - PSP
            - PT
            - SCP
        origin:
          type: string
          description: Institution data origin
        originId:
          type: string
          description: Institution's details origin Id
        pspData:
          description: Payment Service Provider (PSP) specific data
          $ref: '#/components/schemas/PspDataResource'
        recipientCode:
          type: string
          description: Billing recipient code
        status:
          type: string
          description: Institution onboarding status
        taxCode:
          type: string
          description: Institution's taxCode
        userProductRoles:
          type: array
          description: Logged user's roles on product
          items:
            type: string
        zipCode:
          type: string
          description: Institution's zipCode
    InvalidParam:
      title: InvalidParam
      required:
        - name
        - reason
      type: object
      properties:
        name:
          type: string
          description: Invalid parameter name.
        reason:
          type: string
          description: Invalid parameter reason.
    Problem:
      title: Problem
      required:
        - status
        - title
      type: object
      properties:
        detail:
          type: string
          description: Human-readable description of this specific problem.
        instance:
          type: string
          description: A URI that describes where the problem occurred.
        invalidParams:
          type: array
          description: A list of invalid parameters details.
          items:
            $ref: '#/components/schemas/InvalidParam'
        status:
          type: integer
          description: The HTTP status code.
          format: int32
          example: 500
        title:
          type: string
          description: Short human-readable summary of the problem.
        type:
          type: string
          description: A URL to a page with more details regarding the problem.
      description: >-
        A "problem detail" as a way to carry machine-readable details of errors
        (https://datatracker.ietf.org/doc/html/rfc7807)
    ProductResource:
      title: ProductResource
      required:
        - contractTemplatePath
        - contractTemplateUpdatedAt
        - contractTemplateVersion
        - createdAt
        - id
        - title
      type: object
      properties:
        contractTemplatePath:
          type: string
          description: The path of contract
        contractTemplateUpdatedAt:
          type: string
          description: Date the contract was postponed
          format: date-time
        contractTemplateVersion:
          type: string
          description: Version of the contract
        createdAt:
          type: string
          description: Date the products was activated/created
          format: date-time
        depictImageUrl:
          type: string
          description: Product's depiction image url
        description:
          type: string
          description: Product's description
        id:
          type: string
          description: Product's unique identifier
        identityTokenAudience:
          type: string
          description: Product's identity token audience
        logo:
          type: string
          description: Product's logo url
        logoBgColor:
          pattern: ^#0-9A-F6$
          type: string
          description: Product logo's background color
        parentId:
          type: string
          description: Root parent of the sub product
        roleManagementURL:
          type: string
          description: Url of the utilities management
        roleMappings:
          type: object
          additionalProperties:
            $ref: '#/components/schemas/ProductRoleInfoRes'
          description: Mappings between Party's and Product's role
        title:
          type: string
          description: Product's title
        urlBO:
          type: string
          description: URL that redirects to the back-office section where is possible to manage the product
        urlPublic:
          type: string
          description: URL that redirects to the public information webpage of the product
    PspDataResource:
      title: PspDataResource
      required:
        - abiCode
        - businessRegisterNumber
        - legalRegisterName
        - legalRegisterNumber
        - vatNumberGroup
      type: object
      properties:
        abiCode:
          type: string
          description: PSP's ABI code
        businessRegisterNumber:
          type: string
          description: PSP's Business Register number
        legalRegisterName:
          type: string
          description: PSP's legal register name
        legalRegisterNumber:
          type: string
          description: PSP's legal register number
        vatNumberGroup:
          type: boolean
          description: PSP's Vat Number group
          example: false
    DpoDataResource:
      title: DpoDataResource
      required:
        - address
        - email
        - pec
      type: object
      properties:
        address:
          type: string
          description: DPO's address
        email:
          type: string
          description: DPO's email
          format: email
          example: email@example.com
        pec:
          type: string
          description: DPO's PEC
          format: email
          example: email@example.com
    CompanyInformationsResource:
      title: CompanyInformationsResource
      type: object
      properties:
        businessRegisterPlace:
          type: string
          description: Institution's business register place
        rea:
          type: string
          description: Institution's REA
        shareCapital:
          type: string
          description: Institution's share capital value
    AssistanceContactsResource:
      title: AssistanceContactsResource
      type: object
      properties:
        supportEmail:
          type: string
          description: Institution's support email contact
          format: email
          example: email@example.com
        supportPhone:
          type: string
          description: Institution's support phone contact
    ProductRoleInfoRes:
      title: ProductRoleInfoRes
      required:
        - multiroleAllowed
        - roles
      type: object
      properties:
        multiroleAllowed:
          type: boolean
          description: Flag indicating if a User can have more than one product role
          example: false
        roles:
          type: array
          description: Available product roles
          items:
            $ref: '#/components/schemas/ProductRole'
    ProductRole:
      title: ProductRole
      required:
        - code
        - description
        - label
      type: object
      properties:
        code:
          type: string
          description: Product role internal code
        description:
          type: string
          description: Product role description
        label:
          type: string
          description: Product role label
    PageOfUserGroupResource:
      title: PageOfUserGroupResource
      required:
        - content
        - number
        - size
        - totalElements
        - totalPages
      type: object
      properties:
        content:
          type: array
          description: The page content
          items:
            "$ref": "#/components/schemas/UserGroupResource"
        number:
          type: integer
          description: The number of the current page
          format: int32
        size:
          type: integer
          description: The size of the page
          format: int32
        totalElements:
          type: integer
          description: The total amount of elements
          format: int64
        totalPages:
          type: integer
          description: The number of total pages
          format: int32
    UserGroupResource:
      title: UserGroupResource
      required:
      - description
      - id
      - institutionId
      - name
      - productId
      - status
      type: object
      properties:
        description:
          type: string
          description: Users group's description
        id:
          type: string
          description: Users group's unique identifier
        institutionId:
          type: string
          description: Users group's institutionId
        name:
          type: string
          description: Users group's name
        productId:
          type: string
          description: Users group's productId
        status:
          type: string
          description: Users group's status
          enum:
          - ACTIVE
          - SUSPENDED
    UserResource:
      title: UserResource
      required:
        - email
        - id
        - name
        - roles
        - surname
      type: object
      properties:
        email:
          type: string
          description: User's institutional email
          format: email
          example: email@example.com
        id:
          type: string
          description: User's unique identifier
          format: uuid
        name:
          type: string
          description: User's name
        roles:
          type: array
          description: User's roles in product
          items:
            type: string
        surname:
          type: string
          description: User's surname
    Institution:
      type: object
      properties:
        id:
          type: string
          format: uuid
          example: 97c0f418-bcb3-48d4-825a-fe8b29ae68e5
        externalId:
          description: external institution id
          example: 'c_f205'
          type: string
        originId:
          description: origin institution id (e.g iPA code)
          example: 'c_f205'
          type: string
        description:
          type: string
          example: AGENCY X
        digitalAddress:
          example: email@pec.mail.org
          format: email
          type: string
        address:
          example: via del campo
          type: string
        zipCode:
          example: 20100
          type: string
        taxCode:
          description: institution tax code
          type: string
        origin:
          type: string
          description: The origin form which the institution has been retrieved
          example: IPA
        institutionType:
          type: string
          description: institution type
          example: PA
        attributes:
          $ref: '#/components/schemas/Attributes'
        paymentServiceProvider:
          $ref: '#/components/schemas/PaymentServiceProvider'
        dataProtectionOfficer:
          $ref: '#/components/schemas/DataProtectionOfficer'
        geographicTaxonomies:
          type: array
          items:
            $ref: '#/components/schemas/GeographicTaxonomy'
        rea:
          description: The institution REA
          type: string
        shareCapital:
          type: string
          description: The institution share capital value
          example: 10000
        businessRegisterPlace:
          type: string
          description: The business register place
          example: Rome
        supportEmail:
          type: string
          description: The support email contact
        supportPhone:
          type: string
          description: The support phone contact
        imported:
          type: boolean
          description: True if institution is stored from batch api
        logo:
          description: URL to institution logo
          format: url
          type: string
      required:
        - id
        - externalId
        - originId
        - description
        - digitalAddress
        - address
        - zipCode
        - taxCode
        - attributes
        - origin
        - geographicTaxonomies
      additionalProperties: false
    Attribute:
      type: object
      properties:
        origin:
          type: string
        code:
          type: string
        description:
          type: string
      required:
        - origin
        - code
        - description
    Attributes:
      type: array
      items:
        $ref: '#/components/schemas/Attribute'
    PaymentServiceProvider:
      type: object
      additionalProperties: false
      properties:
        abiCode:
          type: string
          description: 'ABI Code'
        businessRegisterNumber:
          type: string
          description: 'ID Registration Number on Business Register'
        legalRegisterName:
          type: string
          description: 'Chairman name on Business Register'
        legalRegisterNumber:
          type: string
          description: 'Chairman ID on Business Register'
        vatNumberGroup:
          type: boolean
          description: 'true when vat number identify a group'
    DataProtectionOfficer:
      type: object
      additionalProperties: false
      properties:
        address:
          type: string
          description: 'Data protection officer address'
        email:
          type: string
          description: 'Data protection officer email'
        pec:
          type: string
          description: 'Data protection officer digital address'
    GeographicTaxonomy:
      type: object
      additionalProperties: false
      required:
        - code
        - desc
      properties:
        code:
          type: string
          description: 'Code of the geographic taxonomy'
        desc:
          type: string
          description: 'Description of the geographic taxonomy code'
  securitySchemes:
    bearerAuth:
      type: http
      description: >-
        A bearer token in the format of a JWS and conformed to the
        specifications included in
        [RFC8725](https://tools.ietf.org/html/RFC8725)
      scheme: bearer
      bearerFormat: JWT
