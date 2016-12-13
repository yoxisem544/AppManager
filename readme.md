# App Manager
A simple way to deal with all things inconvenient while fetching token or user information.

Thanks to [SwiftyUserDefaults](https://github.com/radex/SwiftyUserDefaults), this makes `UserDefaults` simpler.

In my condition, I have to store access token and user's information in my app. These information will determine whether user is logged in or not.

## Access Token
Let's look at access token first. With OAuth 2.0, you have to grant a token from server first in order to make the api call. First thing we have to do is to manage the token.

### AccessTokenManageable
Before we create a manager. We should make a protocol to constraint what a token manager should do.
1. a token getter
2. can update stored token
3. can reset toke

```swift
protocol AccessTokenManageable { 
    /// Get token.
    var token: String? { get }
    /// Update stored token
    ///
    /// - Parameter token: a string of token
    func update(token: String)
    /// Reset token.
    func resetToken()
}
```

### Token Manager
Here, I am going to make this manager a singleton. Inside this manager, we will have a key point to where we store token. Also, we need to get access to Keychain.

```swift
import KeychainAccess

final public class AccessTokenManager {
    
    fileprivate let keychain: Keychain = Keychain()
    fileprivate var tokenKey: String { return "unique_token_key" }
    
    private init() {}
    
    @discardableResult
    public class func shared() -> AccessTokenManager {
        struct Static {
            static let instance: AccessTokenManager = AccessTokenManager()
        }
        return Static.instance
    }
    
}
```

After creating our manager, we also need to make manager conform to `AccessTokenManageable` protocol.

```swift
extension AccessTokenManager : AccessTokenManageable {
    
    public var token: String? { return keychain[tokenKey] }
    
    public func update(token: String) {
        keychain[tokenKey] = token
    }
    
    public func resetToken() {
        keychain[tokenKey] = nil
    }
    
}
```

## User's Information
UserDefaults is often used in iOS to store user's preferences. We all now getting data from UserDefaults is not convenient and we often get nil if we enter the wrong key.

### Seperate Keys
So, I am going to define the keys in a seperate file. Here is my sample. First, define a private struct that store all keys we need. Then, with [SwiftyUserDefaults](https://github.com/radex/SwiftyUserDefaults)'s help, we are able to define special key with type indicated. We will see the magic later.

```swift
private struct UserInformationKeys {
    static let id = "UserInformationKey id"
    static let name = "UserInformationKey name"
    static let facebookID = "UserInformationKey facebookID"
    static let organization = "UserInformationKey organization"
    static let department = "UserInformationKey department"
    static let email = "UserInformationKey email"
}

extension DefaultsKeys {
    static let id = DefaultsKey<Int?>(UserInformationKeys.id)
    static let name = DefaultsKey<String?>(UserInformationKeys.name)
    static let facebookID = DefaultsKey<Double?>(UserInformationKeys.facebookID)
    static let organization = DefaultsKey<String?>(UserInformationKeys.organization)
    static let department = DefaultsKey<String?>(UserInformationKeys.department)
    static let email = DefaultsKey<String?>(UserInformationKeys.email)
}
```

### Define UserInformationManageable Protocol
Define getter and setter for the data you want to get from a manager.

```swift
public protocol UserInformationManageable {
    
    var id: Int? { get set }
    var name: String? { get set }
    var facebookID: Double? { get set }
    var organization: String? { get set }
    var department: String? { get set }
    var email: String? { get set }
    
}
```

### Create UserInformation
UserInformation is also a singleton.

```swift
final public class UserInformation {
    
    private init() {}
    
    @discardableResult
    public class func shared() -> UserInformation {
        struct Static {
            static let instance: UserInformation = UserInformation()
        }
        return Static.instance
    }
    
}
```

After creating the manager, we are going to extend UserInformation. With [SwiftyUserDefaults](https://github.com/radex/SwiftyUserDefaults)'s help, we can do the magic now!

All you need to do is return a subscript with a predefine key with a dot notation. Setter is also the same. You don't have to care what the key is, just get and set.

```swift
extension UserInformation : UserInformationManageable {
    
    public var id: Int? {
        get { return Defaults[.id] }
        set { Defaults[.id] = newValue }
    }
    
    public var name: String? {
        get { return Defaults[.name] }
        set { Defaults[.name] = newValue }
    }
    
    public var facebookID: Double? {
        get { return Defaults[.facebookID] }
        set { Defaults[.facebookID] = newValue }
    }
    
    public var organization: String? {
        get { return Defaults[.organization] }
        set { Defaults[.organization] = newValue }
    }
    
    public var department: String? {
        get { return Defaults[.department] }
        set { Defaults[.department] = newValue }
    }
    
    public var email: String? {
        get { return Defaults[.email] }
        set { Defaults[.email] = newValue }
    }
    
}
```

## App Manager
We now have two managers, one to manage token, one to maange user's information.

### Managing The App
In order to manage the app, we need two managers to help us. Aslo, we will have to determine whether user is logged in or not.

```swift
public protocol AppManageable {
    var tokenManger: AccessTokenManager { get }
    /// Do all things with user' information
    var user: UserInformation { get }
    /// To check user is logged in.
    var isLoggedIn: Bool { get }
}
```

### App Manager
AppManager is also a singleton, same as above.
```swift
final public class AppManager {
    
    private init() {}
    
    @discardableResult
    public class func shared() -> AppManager {
        struct Static {
            static let instance: AppManager = AppManager()
        }
        return Static.instance
    }
    
}
```

What we need to do here is to extend it. Just return singletons of `AccessTokenManager` and `UserInformation`. Use information that two manager gave us to determine the login state. Check if token exists, check if user has id and username, something like that.

```swift
extension AppManager : AppManageable {
    
    public var tokenManger: AccessTokenManager { return AccessTokenManager.shared() }
    
    public var user: UserInformation { return UserInformation.shared() }
    
    public var isLoggedIn: Bool {
        return false
    }
    
}
```