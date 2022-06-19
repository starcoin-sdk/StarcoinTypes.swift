import Serde

public struct AccessPath: Hashable {
    @Indirect public var field0: AccountAddress
    @Indirect public var field1: DataPath

    public init(field0: AccountAddress, field1: DataPath) {
        self.field0 = field0
        self.field1 = field1
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try self.field0.serialize(serializer: serializer)
        try self.field1.serialize(serializer: serializer)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> AccessPath {
        try deserializer.increase_container_depth()
        let field0 = try AccountAddress.deserialize(deserializer: deserializer)
        let field1 = try DataPath.deserialize(deserializer: deserializer)
        try deserializer.decrease_container_depth()
        return AccessPath.init(field0: field0, field1: field1)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> AccessPath {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct AccountAddress: Hashable {
    @Indirect public var value: [UInt8]

    public init(value: [UInt8]) {
        self.value = value
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try serialize_array16_u8_array(value: self.value, serializer: serializer)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> AccountAddress {
        try deserializer.increase_container_depth()
        let value = try deserialize_array16_u8_array(deserializer: deserializer)
        try deserializer.decrease_container_depth()
        return AccountAddress.init(value: value)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> AccountAddress {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct AccountResource: Hashable {
    @Indirect public var authentication_key: [UInt8]
    @Indirect public var withdrawal_capability: WithdrawCapabilityResource?
    @Indirect public var key_rotation_capability: KeyRotationCapabilityResource?
    @Indirect public var withdraw_events: EventHandle
    @Indirect public var deposit_events: EventHandle
    @Indirect public var accept_token_events: EventHandle
    @Indirect public var sequence_number: UInt64

    public init(authentication_key: [UInt8], withdrawal_capability: WithdrawCapabilityResource?, key_rotation_capability: KeyRotationCapabilityResource?, withdraw_events: EventHandle, deposit_events: EventHandle, accept_token_events: EventHandle, sequence_number: UInt64) {
        self.authentication_key = authentication_key
        self.withdrawal_capability = withdrawal_capability
        self.key_rotation_capability = key_rotation_capability
        self.withdraw_events = withdraw_events
        self.deposit_events = deposit_events
        self.accept_token_events = accept_token_events
        self.sequence_number = sequence_number
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try serialize_vector_u8(value: self.authentication_key, serializer: serializer)
        try serialize_option_WithdrawCapabilityResource(value: self.withdrawal_capability, serializer: serializer)
        try serialize_option_KeyRotationCapabilityResource(value: self.key_rotation_capability, serializer: serializer)
        try self.withdraw_events.serialize(serializer: serializer)
        try self.deposit_events.serialize(serializer: serializer)
        try self.accept_token_events.serialize(serializer: serializer)
        try serializer.serialize_u64(value: self.sequence_number)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> AccountResource {
        try deserializer.increase_container_depth()
        let authentication_key = try deserialize_vector_u8(deserializer: deserializer)
        let withdrawal_capability = try deserialize_option_WithdrawCapabilityResource(deserializer: deserializer)
        let key_rotation_capability = try deserialize_option_KeyRotationCapabilityResource(deserializer: deserializer)
        let withdraw_events = try EventHandle.deserialize(deserializer: deserializer)
        let deposit_events = try EventHandle.deserialize(deserializer: deserializer)
        let accept_token_events = try EventHandle.deserialize(deserializer: deserializer)
        let sequence_number = try deserializer.deserialize_u64()
        try deserializer.decrease_container_depth()
        return AccountResource.init(authentication_key: authentication_key, withdrawal_capability: withdrawal_capability, key_rotation_capability: key_rotation_capability, withdraw_events: withdraw_events, deposit_events: deposit_events, accept_token_events: accept_token_events, sequence_number: sequence_number)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> AccountResource {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct ArgumentABI: Hashable {
    @Indirect public var name: String
    @Indirect public var type_tag: TypeTag

    public init(name: String, type_tag: TypeTag) {
        self.name = name
        self.type_tag = type_tag
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try serializer.serialize_str(value: self.name)
        try self.type_tag.serialize(serializer: serializer)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> ArgumentABI {
        try deserializer.increase_container_depth()
        let name = try deserializer.deserialize_str()
        let type_tag = try TypeTag.deserialize(deserializer: deserializer)
        try deserializer.decrease_container_depth()
        return ArgumentABI.init(name: name, type_tag: type_tag)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> ArgumentABI {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct AuthenticationKey: Hashable {
    @Indirect public var value: [UInt8]

    public init(value: [UInt8]) {
        self.value = value
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try serializer.serialize_bytes(value: self.value)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> AuthenticationKey {
        try deserializer.increase_container_depth()
        let value = try deserializer.deserialize_bytes()
        try deserializer.decrease_container_depth()
        return AuthenticationKey.init(value: value)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> AuthenticationKey {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct BlockMetadata: Hashable {
    @Indirect public var parent_hash: HashValue
    @Indirect public var timestamp: UInt64
    @Indirect public var author: AccountAddress
    @Indirect public var author_auth_key: AuthenticationKey?
    @Indirect public var uncles: UInt64
    @Indirect public var number: UInt64
    @Indirect public var chain_id: ChainId
    @Indirect public var parent_gas_used: UInt64

    public init(parent_hash: HashValue, timestamp: UInt64, author: AccountAddress, author_auth_key: AuthenticationKey?, uncles: UInt64, number: UInt64, chain_id: ChainId, parent_gas_used: UInt64) {
        self.parent_hash = parent_hash
        self.timestamp = timestamp
        self.author = author
        self.author_auth_key = author_auth_key
        self.uncles = uncles
        self.number = number
        self.chain_id = chain_id
        self.parent_gas_used = parent_gas_used
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try self.parent_hash.serialize(serializer: serializer)
        try serializer.serialize_u64(value: self.timestamp)
        try self.author.serialize(serializer: serializer)
        try serialize_option_AuthenticationKey(value: self.author_auth_key, serializer: serializer)
        try serializer.serialize_u64(value: self.uncles)
        try serializer.serialize_u64(value: self.number)
        try self.chain_id.serialize(serializer: serializer)
        try serializer.serialize_u64(value: self.parent_gas_used)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> BlockMetadata {
        try deserializer.increase_container_depth()
        let parent_hash = try HashValue.deserialize(deserializer: deserializer)
        let timestamp = try deserializer.deserialize_u64()
        let author = try AccountAddress.deserialize(deserializer: deserializer)
        let author_auth_key = try deserialize_option_AuthenticationKey(deserializer: deserializer)
        let uncles = try deserializer.deserialize_u64()
        let number = try deserializer.deserialize_u64()
        let chain_id = try ChainId.deserialize(deserializer: deserializer)
        let parent_gas_used = try deserializer.deserialize_u64()
        try deserializer.decrease_container_depth()
        return BlockMetadata.init(parent_hash: parent_hash, timestamp: timestamp, author: author, author_auth_key: author_auth_key, uncles: uncles, number: number, chain_id: chain_id, parent_gas_used: parent_gas_used)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> BlockMetadata {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct ChainId: Hashable {
    @Indirect public var id: UInt8

    public init(id: UInt8) {
        self.id = id
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try serializer.serialize_u8(value: self.id)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> ChainId {
        try deserializer.increase_container_depth()
        let id = try deserializer.deserialize_u8()
        try deserializer.decrease_container_depth()
        return ChainId.init(id: id)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> ChainId {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

indirect public enum ContractEvent: Hashable {
    case v0(ContractEventV0)

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        switch self {
        case .v0(let x):
            try serializer.serialize_variant_index(value: 0)
            try x.serialize(serializer: serializer)
        }
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> ContractEvent {
        let index = try deserializer.deserialize_variant_index()
        try deserializer.increase_container_depth()
        switch index {
        case 0:
            let x = try ContractEventV0.deserialize(deserializer: deserializer)
            try deserializer.decrease_container_depth()
            return .v0(x)
        default: throw DeserializationError.invalidInput(issue: "Unknown variant index for ContractEvent: \(index)")
        }
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> ContractEvent {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct ContractEventV0: Hashable {
    @Indirect public var key: EventKey
    @Indirect public var sequence_number: UInt64
    @Indirect public var type_tag: TypeTag
    @Indirect public var event_data: [UInt8]

    public init(key: EventKey, sequence_number: UInt64, type_tag: TypeTag, event_data: [UInt8]) {
        self.key = key
        self.sequence_number = sequence_number
        self.type_tag = type_tag
        self.event_data = event_data
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try self.key.serialize(serializer: serializer)
        try serializer.serialize_u64(value: self.sequence_number)
        try self.type_tag.serialize(serializer: serializer)
        try serializer.serialize_bytes(value: self.event_data)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> ContractEventV0 {
        try deserializer.increase_container_depth()
        let key = try EventKey.deserialize(deserializer: deserializer)
        let sequence_number = try deserializer.deserialize_u64()
        let type_tag = try TypeTag.deserialize(deserializer: deserializer)
        let event_data = try deserializer.deserialize_bytes()
        try deserializer.decrease_container_depth()
        return ContractEventV0.init(key: key, sequence_number: sequence_number, type_tag: type_tag, event_data: event_data)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> ContractEventV0 {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

indirect public enum DataPath: Hashable {
    case code(Identifier)
    case resource(StructTag)

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        switch self {
        case .code(let x):
            try serializer.serialize_variant_index(value: 0)
            try x.serialize(serializer: serializer)
        case .resource(let x):
            try serializer.serialize_variant_index(value: 1)
            try x.serialize(serializer: serializer)
        }
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> DataPath {
        let index = try deserializer.deserialize_variant_index()
        try deserializer.increase_container_depth()
        switch index {
        case 0:
            let x = try Identifier.deserialize(deserializer: deserializer)
            try deserializer.decrease_container_depth()
            return .code(x)
        case 1:
            let x = try StructTag.deserialize(deserializer: deserializer)
            try deserializer.decrease_container_depth()
            return .resource(x)
        default: throw DeserializationError.invalidInput(issue: "Unknown variant index for DataPath: \(index)")
        }
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> DataPath {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

indirect public enum DataType: Hashable {
    case cODE
    case rESOURCE

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        switch self {
        case .cODE:
            try serializer.serialize_variant_index(value: 0)
        case .rESOURCE:
            try serializer.serialize_variant_index(value: 1)
        }
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> DataType {
        let index = try deserializer.deserialize_variant_index()
        try deserializer.increase_container_depth()
        switch index {
        case 0:
            try deserializer.decrease_container_depth()
            return .cODE
        case 1:
            try deserializer.decrease_container_depth()
            return .rESOURCE
        default: throw DeserializationError.invalidInput(issue: "Unknown variant index for DataType: \(index)")
        }
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> DataType {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct Ed25519PrivateKey: Hashable {
    @Indirect public var value: [UInt8]

    public init(value: [UInt8]) {
        self.value = value
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try serializer.serialize_bytes(value: self.value)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> Ed25519PrivateKey {
        try deserializer.increase_container_depth()
        let value = try deserializer.deserialize_bytes()
        try deserializer.decrease_container_depth()
        return Ed25519PrivateKey.init(value: value)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> Ed25519PrivateKey {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct Ed25519PublicKey: Hashable {
    @Indirect public var value: [UInt8]

    public init(value: [UInt8]) {
        self.value = value
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try serializer.serialize_bytes(value: self.value)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> Ed25519PublicKey {
        try deserializer.increase_container_depth()
        let value = try deserializer.deserialize_bytes()
        try deserializer.decrease_container_depth()
        return Ed25519PublicKey.init(value: value)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> Ed25519PublicKey {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct Ed25519Signature: Hashable {
    @Indirect public var value: [UInt8]

    public init(value: [UInt8]) {
        self.value = value
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try serializer.serialize_bytes(value: self.value)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> Ed25519Signature {
        try deserializer.increase_container_depth()
        let value = try deserializer.deserialize_bytes()
        try deserializer.decrease_container_depth()
        return Ed25519Signature.init(value: value)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> Ed25519Signature {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct EventHandle: Hashable {
    @Indirect public var count: UInt64
    @Indirect public var key: EventKey

    public init(count: UInt64, key: EventKey) {
        self.count = count
        self.key = key
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try serializer.serialize_u64(value: self.count)
        try self.key.serialize(serializer: serializer)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> EventHandle {
        try deserializer.increase_container_depth()
        let count = try deserializer.deserialize_u64()
        let key = try EventKey.deserialize(deserializer: deserializer)
        try deserializer.decrease_container_depth()
        return EventHandle.init(count: count, key: key)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> EventHandle {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct EventKey: Hashable {
    @Indirect public var value: [UInt8]

    public init(value: [UInt8]) {
        self.value = value
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try serializer.serialize_bytes(value: self.value)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> EventKey {
        try deserializer.increase_container_depth()
        let value = try deserializer.deserialize_bytes()
        try deserializer.decrease_container_depth()
        return EventKey.init(value: value)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> EventKey {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct HashValue: Hashable {
    @Indirect public var value: [UInt8]

    public init(value: [UInt8]) {
        self.value = value
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try serializer.serialize_bytes(value: self.value)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> HashValue {
        try deserializer.increase_container_depth()
        let value = try deserializer.deserialize_bytes()
        try deserializer.decrease_container_depth()
        return HashValue.init(value: value)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> HashValue {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct Identifier: Hashable {
    @Indirect public var value: String

    public init(value: String) {
        self.value = value
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try serializer.serialize_str(value: self.value)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> Identifier {
        try deserializer.increase_container_depth()
        let value = try deserializer.deserialize_str()
        try deserializer.decrease_container_depth()
        return Identifier.init(value: value)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> Identifier {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct KeyRotationCapabilityResource: Hashable {
    @Indirect public var account_address: AccountAddress

    public init(account_address: AccountAddress) {
        self.account_address = account_address
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try self.account_address.serialize(serializer: serializer)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> KeyRotationCapabilityResource {
        try deserializer.increase_container_depth()
        let account_address = try AccountAddress.deserialize(deserializer: deserializer)
        try deserializer.decrease_container_depth()
        return KeyRotationCapabilityResource.init(account_address: account_address)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> KeyRotationCapabilityResource {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct Module: Hashable {
    @Indirect public var code: [UInt8]

    public init(code: [UInt8]) {
        self.code = code
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try serializer.serialize_bytes(value: self.code)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> Module {
        try deserializer.increase_container_depth()
        let code = try deserializer.deserialize_bytes()
        try deserializer.decrease_container_depth()
        return Module.init(code: code)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> Module {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct ModuleId: Hashable {
    @Indirect public var address: AccountAddress
    @Indirect public var name: Identifier

    public init(address: AccountAddress, name: Identifier) {
        self.address = address
        self.name = name
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try self.address.serialize(serializer: serializer)
        try self.name.serialize(serializer: serializer)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> ModuleId {
        try deserializer.increase_container_depth()
        let address = try AccountAddress.deserialize(deserializer: deserializer)
        let name = try Identifier.deserialize(deserializer: deserializer)
        try deserializer.decrease_container_depth()
        return ModuleId.init(address: address, name: name)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> ModuleId {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct MultiEd25519PrivateKey: Hashable {
    @Indirect public var value: [UInt8]

    public init(value: [UInt8]) {
        self.value = value
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try serializer.serialize_bytes(value: self.value)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> MultiEd25519PrivateKey {
        try deserializer.increase_container_depth()
        let value = try deserializer.deserialize_bytes()
        try deserializer.decrease_container_depth()
        return MultiEd25519PrivateKey.init(value: value)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> MultiEd25519PrivateKey {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct MultiEd25519PublicKey: Hashable {
    @Indirect public var value: [UInt8]

    public init(value: [UInt8]) {
        self.value = value
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try serializer.serialize_bytes(value: self.value)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> MultiEd25519PublicKey {
        try deserializer.increase_container_depth()
        let value = try deserializer.deserialize_bytes()
        try deserializer.decrease_container_depth()
        return MultiEd25519PublicKey.init(value: value)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> MultiEd25519PublicKey {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct MultiEd25519Signature: Hashable {
    @Indirect public var value: [UInt8]

    public init(value: [UInt8]) {
        self.value = value
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try serializer.serialize_bytes(value: self.value)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> MultiEd25519Signature {
        try deserializer.increase_container_depth()
        let value = try deserializer.deserialize_bytes()
        try deserializer.decrease_container_depth()
        return MultiEd25519Signature.init(value: value)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> MultiEd25519Signature {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct Package: Hashable {
    @Indirect public var package_address: AccountAddress
    @Indirect public var modules: [Module]
    @Indirect public var init_script: ScriptFunction?

    public init(package_address: AccountAddress, modules: [Module], init_script: ScriptFunction?) {
        self.package_address = package_address
        self.modules = modules
        self.init_script = init_script
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try self.package_address.serialize(serializer: serializer)
        try serialize_vector_Module(value: self.modules, serializer: serializer)
        try serialize_option_ScriptFunction(value: self.init_script, serializer: serializer)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> Package {
        try deserializer.increase_container_depth()
        let package_address = try AccountAddress.deserialize(deserializer: deserializer)
        let modules = try deserialize_vector_Module(deserializer: deserializer)
        let init_script = try deserialize_option_ScriptFunction(deserializer: deserializer)
        try deserializer.decrease_container_depth()
        return Package.init(package_address: package_address, modules: modules, init_script: init_script)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> Package {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct RawUserTransaction: Hashable {
    @Indirect public var sender: AccountAddress
    @Indirect public var sequence_number: UInt64
    @Indirect public var payload: TransactionPayload
    @Indirect public var max_gas_amount: UInt64
    @Indirect public var gas_unit_price: UInt64
    @Indirect public var gas_token_code: String
    @Indirect public var expiration_timestamp_secs: UInt64
    @Indirect public var chain_id: ChainId

    public init(sender: AccountAddress, sequence_number: UInt64, payload: TransactionPayload, max_gas_amount: UInt64, gas_unit_price: UInt64, gas_token_code: String, expiration_timestamp_secs: UInt64, chain_id: ChainId) {
        self.sender = sender
        self.sequence_number = sequence_number
        self.payload = payload
        self.max_gas_amount = max_gas_amount
        self.gas_unit_price = gas_unit_price
        self.gas_token_code = gas_token_code
        self.expiration_timestamp_secs = expiration_timestamp_secs
        self.chain_id = chain_id
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try self.sender.serialize(serializer: serializer)
        try serializer.serialize_u64(value: self.sequence_number)
        try self.payload.serialize(serializer: serializer)
        try serializer.serialize_u64(value: self.max_gas_amount)
        try serializer.serialize_u64(value: self.gas_unit_price)
        try serializer.serialize_str(value: self.gas_token_code)
        try serializer.serialize_u64(value: self.expiration_timestamp_secs)
        try self.chain_id.serialize(serializer: serializer)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> RawUserTransaction {
        try deserializer.increase_container_depth()
        let sender = try AccountAddress.deserialize(deserializer: deserializer)
        let sequence_number = try deserializer.deserialize_u64()
        let payload = try TransactionPayload.deserialize(deserializer: deserializer)
        let max_gas_amount = try deserializer.deserialize_u64()
        let gas_unit_price = try deserializer.deserialize_u64()
        let gas_token_code = try deserializer.deserialize_str()
        let expiration_timestamp_secs = try deserializer.deserialize_u64()
        let chain_id = try ChainId.deserialize(deserializer: deserializer)
        try deserializer.decrease_container_depth()
        return RawUserTransaction.init(sender: sender, sequence_number: sequence_number, payload: payload, max_gas_amount: max_gas_amount, gas_unit_price: gas_unit_price, gas_token_code: gas_token_code, expiration_timestamp_secs: expiration_timestamp_secs, chain_id: chain_id)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> RawUserTransaction {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct Script: Hashable {
    @Indirect public var code: [UInt8]
    @Indirect public var ty_args: [TypeTag]
    @Indirect public var args: [[UInt8]]

    public init(code: [UInt8], ty_args: [TypeTag], args: [[UInt8]]) {
        self.code = code
        self.ty_args = ty_args
        self.args = args
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try serializer.serialize_bytes(value: self.code)
        try serialize_vector_TypeTag(value: self.ty_args, serializer: serializer)
        try serialize_vector_bytes(value: self.args, serializer: serializer)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> Script {
        try deserializer.increase_container_depth()
        let code = try deserializer.deserialize_bytes()
        let ty_args = try deserialize_vector_TypeTag(deserializer: deserializer)
        let args = try deserialize_vector_bytes(deserializer: deserializer)
        try deserializer.decrease_container_depth()
        return Script.init(code: code, ty_args: ty_args, args: args)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> Script {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

indirect public enum ScriptABI: Hashable {
    case transactionScript(TransactionScriptABI)
    case scriptFunction(ScriptFunctionABI)

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        switch self {
        case .transactionScript(let x):
            try serializer.serialize_variant_index(value: 0)
            try x.serialize(serializer: serializer)
        case .scriptFunction(let x):
            try serializer.serialize_variant_index(value: 1)
            try x.serialize(serializer: serializer)
        }
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> ScriptABI {
        let index = try deserializer.deserialize_variant_index()
        try deserializer.increase_container_depth()
        switch index {
        case 0:
            let x = try TransactionScriptABI.deserialize(deserializer: deserializer)
            try deserializer.decrease_container_depth()
            return .transactionScript(x)
        case 1:
            let x = try ScriptFunctionABI.deserialize(deserializer: deserializer)
            try deserializer.decrease_container_depth()
            return .scriptFunction(x)
        default: throw DeserializationError.invalidInput(issue: "Unknown variant index for ScriptABI: \(index)")
        }
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> ScriptABI {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct ScriptFunction: Hashable {
    @Indirect public var module: ModuleId
    @Indirect public var function: Identifier
    @Indirect public var ty_args: [TypeTag]
    @Indirect public var args: [[UInt8]]

    public init(module: ModuleId, function: Identifier, ty_args: [TypeTag], args: [[UInt8]]) {
        self.module = module
        self.function = function
        self.ty_args = ty_args
        self.args = args
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try self.module.serialize(serializer: serializer)
        try self.function.serialize(serializer: serializer)
        try serialize_vector_TypeTag(value: self.ty_args, serializer: serializer)
        try serialize_vector_bytes(value: self.args, serializer: serializer)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> ScriptFunction {
        try deserializer.increase_container_depth()
        let module = try ModuleId.deserialize(deserializer: deserializer)
        let function = try Identifier.deserialize(deserializer: deserializer)
        let ty_args = try deserialize_vector_TypeTag(deserializer: deserializer)
        let args = try deserialize_vector_bytes(deserializer: deserializer)
        try deserializer.decrease_container_depth()
        return ScriptFunction.init(module: module, function: function, ty_args: ty_args, args: args)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> ScriptFunction {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct ScriptFunctionABI: Hashable {
    @Indirect public var name: String
    @Indirect public var module_name: ModuleId
    @Indirect public var doc: String
    @Indirect public var ty_args: [TypeArgumentABI]
    @Indirect public var args: [ArgumentABI]

    public init(name: String, module_name: ModuleId, doc: String, ty_args: [TypeArgumentABI], args: [ArgumentABI]) {
        self.name = name
        self.module_name = module_name
        self.doc = doc
        self.ty_args = ty_args
        self.args = args
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try serializer.serialize_str(value: self.name)
        try self.module_name.serialize(serializer: serializer)
        try serializer.serialize_str(value: self.doc)
        try serialize_vector_TypeArgumentABI(value: self.ty_args, serializer: serializer)
        try serialize_vector_ArgumentABI(value: self.args, serializer: serializer)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> ScriptFunctionABI {
        try deserializer.increase_container_depth()
        let name = try deserializer.deserialize_str()
        let module_name = try ModuleId.deserialize(deserializer: deserializer)
        let doc = try deserializer.deserialize_str()
        let ty_args = try deserialize_vector_TypeArgumentABI(deserializer: deserializer)
        let args = try deserialize_vector_ArgumentABI(deserializer: deserializer)
        try deserializer.decrease_container_depth()
        return ScriptFunctionABI.init(name: name, module_name: module_name, doc: doc, ty_args: ty_args, args: args)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> ScriptFunctionABI {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct SignedMessage: Hashable {
    @Indirect public var account: AccountAddress
    @Indirect public var message: SigningMessage
    @Indirect public var authenticator: TransactionAuthenticator
    @Indirect public var chain_id: ChainId

    public init(account: AccountAddress, message: SigningMessage, authenticator: TransactionAuthenticator, chain_id: ChainId) {
        self.account = account
        self.message = message
        self.authenticator = authenticator
        self.chain_id = chain_id
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try self.account.serialize(serializer: serializer)
        try self.message.serialize(serializer: serializer)
        try self.authenticator.serialize(serializer: serializer)
        try self.chain_id.serialize(serializer: serializer)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> SignedMessage {
        try deserializer.increase_container_depth()
        let account = try AccountAddress.deserialize(deserializer: deserializer)
        let message = try SigningMessage.deserialize(deserializer: deserializer)
        let authenticator = try TransactionAuthenticator.deserialize(deserializer: deserializer)
        let chain_id = try ChainId.deserialize(deserializer: deserializer)
        try deserializer.decrease_container_depth()
        return SignedMessage.init(account: account, message: message, authenticator: authenticator, chain_id: chain_id)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> SignedMessage {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct SignedUserTransaction: Hashable {
    @Indirect public var raw_txn: RawUserTransaction
    @Indirect public var authenticator: TransactionAuthenticator

    public init(raw_txn: RawUserTransaction, authenticator: TransactionAuthenticator) {
        self.raw_txn = raw_txn
        self.authenticator = authenticator
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try self.raw_txn.serialize(serializer: serializer)
        try self.authenticator.serialize(serializer: serializer)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> SignedUserTransaction {
        try deserializer.increase_container_depth()
        let raw_txn = try RawUserTransaction.deserialize(deserializer: deserializer)
        let authenticator = try TransactionAuthenticator.deserialize(deserializer: deserializer)
        try deserializer.decrease_container_depth()
        return SignedUserTransaction.init(raw_txn: raw_txn, authenticator: authenticator)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> SignedUserTransaction {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct SigningMessage: Hashable {
    @Indirect public var value: [UInt8]

    public init(value: [UInt8]) {
        self.value = value
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try serialize_vector_u8(value: self.value, serializer: serializer)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> SigningMessage {
        try deserializer.increase_container_depth()
        let value = try deserialize_vector_u8(deserializer: deserializer)
        try deserializer.decrease_container_depth()
        return SigningMessage.init(value: value)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> SigningMessage {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct StructTag: Hashable {
    @Indirect public var address: AccountAddress
    @Indirect public var module: Identifier
    @Indirect public var name: Identifier
    @Indirect public var type_args: [TypeTag]

    public init(address: AccountAddress, module: Identifier, name: Identifier, type_args: [TypeTag]) {
        self.address = address
        self.module = module
        self.name = name
        self.type_args = type_args
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try self.address.serialize(serializer: serializer)
        try self.module.serialize(serializer: serializer)
        try self.name.serialize(serializer: serializer)
        try serialize_vector_TypeTag(value: self.type_args, serializer: serializer)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> StructTag {
        try deserializer.increase_container_depth()
        let address = try AccountAddress.deserialize(deserializer: deserializer)
        let module = try Identifier.deserialize(deserializer: deserializer)
        let name = try Identifier.deserialize(deserializer: deserializer)
        let type_args = try deserialize_vector_TypeTag(deserializer: deserializer)
        try deserializer.decrease_container_depth()
        return StructTag.init(address: address, module: module, name: name, type_args: type_args)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> StructTag {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

indirect public enum Transaction: Hashable {
    case userTransaction(SignedUserTransaction)
    case blockMetadata(BlockMetadata)

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        switch self {
        case .userTransaction(let x):
            try serializer.serialize_variant_index(value: 0)
            try x.serialize(serializer: serializer)
        case .blockMetadata(let x):
            try serializer.serialize_variant_index(value: 1)
            try x.serialize(serializer: serializer)
        }
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> Transaction {
        let index = try deserializer.deserialize_variant_index()
        try deserializer.increase_container_depth()
        switch index {
        case 0:
            let x = try SignedUserTransaction.deserialize(deserializer: deserializer)
            try deserializer.decrease_container_depth()
            return .userTransaction(x)
        case 1:
            let x = try BlockMetadata.deserialize(deserializer: deserializer)
            try deserializer.decrease_container_depth()
            return .blockMetadata(x)
        default: throw DeserializationError.invalidInput(issue: "Unknown variant index for Transaction: \(index)")
        }
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> Transaction {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

indirect public enum TransactionArgument: Hashable {
    case u8(UInt8)
    case u64(UInt64)
    case u128(UInt128)
    case address(AccountAddress)
    case u8Vector([UInt8])
    case bool(Bool)

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        switch self {
        case .u8(let x):
            try serializer.serialize_variant_index(value: 0)
            try serializer.serialize_u8(value: x)
        case .u64(let x):
            try serializer.serialize_variant_index(value: 1)
            try serializer.serialize_u64(value: x)
        case .u128(let x):
            try serializer.serialize_variant_index(value: 2)
            try serializer.serialize_u128(value: x)
        case .address(let x):
            try serializer.serialize_variant_index(value: 3)
            try x.serialize(serializer: serializer)
        case .u8Vector(let x):
            try serializer.serialize_variant_index(value: 4)
            try serializer.serialize_bytes(value: x)
        case .bool(let x):
            try serializer.serialize_variant_index(value: 5)
            try serializer.serialize_bool(value: x)
        }
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> TransactionArgument {
        let index = try deserializer.deserialize_variant_index()
        try deserializer.increase_container_depth()
        switch index {
        case 0:
            let x = try deserializer.deserialize_u8()
            try deserializer.decrease_container_depth()
            return .u8(x)
        case 1:
            let x = try deserializer.deserialize_u64()
            try deserializer.decrease_container_depth()
            return .u64(x)
        case 2:
            let x = try deserializer.deserialize_u128()
            try deserializer.decrease_container_depth()
            return .u128(x)
        case 3:
            let x = try AccountAddress.deserialize(deserializer: deserializer)
            try deserializer.decrease_container_depth()
            return .address(x)
        case 4:
            let x = try deserializer.deserialize_bytes()
            try deserializer.decrease_container_depth()
            return .u8Vector(x)
        case 5:
            let x = try deserializer.deserialize_bool()
            try deserializer.decrease_container_depth()
            return .bool(x)
        default: throw DeserializationError.invalidInput(issue: "Unknown variant index for TransactionArgument: \(index)")
        }
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> TransactionArgument {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

indirect public enum TransactionAuthenticator: Hashable {
    case ed25519(public_key: Ed25519PublicKey, signature: Ed25519Signature)
    case multiEd25519(public_key: MultiEd25519PublicKey, signature: MultiEd25519Signature)

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        switch self {
        case .ed25519(let public_key, let signature):
            try serializer.serialize_variant_index(value: 0)
            try public_key.serialize(serializer: serializer)
            try signature.serialize(serializer: serializer)
        case .multiEd25519(let public_key, let signature):
            try serializer.serialize_variant_index(value: 1)
            try public_key.serialize(serializer: serializer)
            try signature.serialize(serializer: serializer)
        }
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> TransactionAuthenticator {
        let index = try deserializer.deserialize_variant_index()
        try deserializer.increase_container_depth()
        switch index {
        case 0:
            let public_key = try Ed25519PublicKey.deserialize(deserializer: deserializer)
            let signature = try Ed25519Signature.deserialize(deserializer: deserializer)
            try deserializer.decrease_container_depth()
            return .ed25519(public_key: public_key, signature: signature)
        case 1:
            let public_key = try MultiEd25519PublicKey.deserialize(deserializer: deserializer)
            let signature = try MultiEd25519Signature.deserialize(deserializer: deserializer)
            try deserializer.decrease_container_depth()
            return .multiEd25519(public_key: public_key, signature: signature)
        default: throw DeserializationError.invalidInput(issue: "Unknown variant index for TransactionAuthenticator: \(index)")
        }
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> TransactionAuthenticator {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

indirect public enum TransactionPayload: Hashable {
    case script(Script)
    case package(Package)
    case scriptFunction(ScriptFunction)

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        switch self {
        case .script(let x):
            try serializer.serialize_variant_index(value: 0)
            try x.serialize(serializer: serializer)
        case .package(let x):
            try serializer.serialize_variant_index(value: 1)
            try x.serialize(serializer: serializer)
        case .scriptFunction(let x):
            try serializer.serialize_variant_index(value: 2)
            try x.serialize(serializer: serializer)
        }
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> TransactionPayload {
        let index = try deserializer.deserialize_variant_index()
        try deserializer.increase_container_depth()
        switch index {
        case 0:
            let x = try Script.deserialize(deserializer: deserializer)
            try deserializer.decrease_container_depth()
            return .script(x)
        case 1:
            let x = try Package.deserialize(deserializer: deserializer)
            try deserializer.decrease_container_depth()
            return .package(x)
        case 2:
            let x = try ScriptFunction.deserialize(deserializer: deserializer)
            try deserializer.decrease_container_depth()
            return .scriptFunction(x)
        default: throw DeserializationError.invalidInput(issue: "Unknown variant index for TransactionPayload: \(index)")
        }
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> TransactionPayload {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct TransactionScriptABI: Hashable {
    @Indirect public var name: String
    @Indirect public var doc: String
    @Indirect public var code: [UInt8]
    @Indirect public var ty_args: [TypeArgumentABI]
    @Indirect public var args: [ArgumentABI]

    public init(name: String, doc: String, code: [UInt8], ty_args: [TypeArgumentABI], args: [ArgumentABI]) {
        self.name = name
        self.doc = doc
        self.code = code
        self.ty_args = ty_args
        self.args = args
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try serializer.serialize_str(value: self.name)
        try serializer.serialize_str(value: self.doc)
        try serializer.serialize_bytes(value: self.code)
        try serialize_vector_TypeArgumentABI(value: self.ty_args, serializer: serializer)
        try serialize_vector_ArgumentABI(value: self.args, serializer: serializer)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> TransactionScriptABI {
        try deserializer.increase_container_depth()
        let name = try deserializer.deserialize_str()
        let doc = try deserializer.deserialize_str()
        let code = try deserializer.deserialize_bytes()
        let ty_args = try deserialize_vector_TypeArgumentABI(deserializer: deserializer)
        let args = try deserialize_vector_ArgumentABI(deserializer: deserializer)
        try deserializer.decrease_container_depth()
        return TransactionScriptABI.init(name: name, doc: doc, code: code, ty_args: ty_args, args: args)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> TransactionScriptABI {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct TypeArgumentABI: Hashable {
    @Indirect public var name: String

    public init(name: String) {
        self.name = name
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try serializer.serialize_str(value: self.name)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> TypeArgumentABI {
        try deserializer.increase_container_depth()
        let name = try deserializer.deserialize_str()
        try deserializer.decrease_container_depth()
        return TypeArgumentABI.init(name: name)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> TypeArgumentABI {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

indirect public enum TypeTag: Hashable {
    case bool
    case u8
    case u64
    case u128
    case address
    case signer
    case vector(TypeTag)
    case `struct`(StructTag)

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        switch self {
        case .bool:
            try serializer.serialize_variant_index(value: 0)
        case .u8:
            try serializer.serialize_variant_index(value: 1)
        case .u64:
            try serializer.serialize_variant_index(value: 2)
        case .u128:
            try serializer.serialize_variant_index(value: 3)
        case .address:
            try serializer.serialize_variant_index(value: 4)
        case .signer:
            try serializer.serialize_variant_index(value: 5)
        case .vector(let x):
            try serializer.serialize_variant_index(value: 6)
            try x.serialize(serializer: serializer)
        case .struct(let x):
            try serializer.serialize_variant_index(value: 7)
            try x.serialize(serializer: serializer)
        }
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> TypeTag {
        let index = try deserializer.deserialize_variant_index()
        try deserializer.increase_container_depth()
        switch index {
        case 0:
            try deserializer.decrease_container_depth()
            return .bool
        case 1:
            try deserializer.decrease_container_depth()
            return .u8
        case 2:
            try deserializer.decrease_container_depth()
            return .u64
        case 3:
            try deserializer.decrease_container_depth()
            return .u128
        case 4:
            try deserializer.decrease_container_depth()
            return .address
        case 5:
            try deserializer.decrease_container_depth()
            return .signer
        case 6:
            let x = try TypeTag.deserialize(deserializer: deserializer)
            try deserializer.decrease_container_depth()
            return .vector(x)
        case 7:
            let x = try StructTag.deserialize(deserializer: deserializer)
            try deserializer.decrease_container_depth()
            return .struct(x)
        default: throw DeserializationError.invalidInput(issue: "Unknown variant index for TypeTag: \(index)")
        }
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> TypeTag {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct WithdrawCapabilityResource: Hashable {
    @Indirect public var account_address: AccountAddress

    public init(account_address: AccountAddress) {
        self.account_address = account_address
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try self.account_address.serialize(serializer: serializer)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> WithdrawCapabilityResource {
        try deserializer.increase_container_depth()
        let account_address = try AccountAddress.deserialize(deserializer: deserializer)
        try deserializer.decrease_container_depth()
        return WithdrawCapabilityResource.init(account_address: account_address)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> WithdrawCapabilityResource {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

indirect public enum WriteOp: Hashable {
    case deletion
    case value([UInt8])

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        switch self {
        case .deletion:
            try serializer.serialize_variant_index(value: 0)
        case .value(let x):
            try serializer.serialize_variant_index(value: 1)
            try serializer.serialize_bytes(value: x)
        }
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> WriteOp {
        let index = try deserializer.deserialize_variant_index()
        try deserializer.increase_container_depth()
        switch index {
        case 0:
            try deserializer.decrease_container_depth()
            return .deletion
        case 1:
            let x = try deserializer.deserialize_bytes()
            try deserializer.decrease_container_depth()
            return .value(x)
        default: throw DeserializationError.invalidInput(issue: "Unknown variant index for WriteOp: \(index)")
        }
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> WriteOp {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct WriteSet: Hashable {
    @Indirect public var value: WriteSetMut

    public init(value: WriteSetMut) {
        self.value = value
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try self.value.serialize(serializer: serializer)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> WriteSet {
        try deserializer.increase_container_depth()
        let value = try WriteSetMut.deserialize(deserializer: deserializer)
        try deserializer.decrease_container_depth()
        return WriteSet.init(value: value)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> WriteSet {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

public struct WriteSetMut: Hashable {
    @Indirect public var write_set: [Tuple2<AccessPath, WriteOp>]

    public init(write_set: [Tuple2<AccessPath, WriteOp>]) {
        self.write_set = write_set
    }

    public func serialize<S: Serializer>(serializer: S) throws {
        try serializer.increase_container_depth()
        try serialize_vector_tuple2_AccessPath_WriteOp(value: self.write_set, serializer: serializer)
        try serializer.decrease_container_depth()
    }

    public func bcsSerialize() throws -> [UInt8] {
        let serializer = BcsSerializer.init();
        try self.serialize(serializer: serializer)
        return serializer.get_bytes()
    }

    public static func deserialize<D: Deserializer>(deserializer: D) throws -> WriteSetMut {
        try deserializer.increase_container_depth()
        let write_set = try deserialize_vector_tuple2_AccessPath_WriteOp(deserializer: deserializer)
        try deserializer.decrease_container_depth()
        return WriteSetMut.init(write_set: write_set)
    }

    public static func bcsDeserialize(input: [UInt8]) throws -> WriteSetMut {
        let deserializer = BcsDeserializer.init(input: input);
        let obj = try deserialize(deserializer: deserializer)
        if deserializer.get_buffer_offset() < input.count {
            throw DeserializationError.invalidInput(issue: "Some input bytes were not read")
        }
        return obj
    }
}

func serialize_array16_u8_array<S: Serializer>(value: [UInt8], serializer: S) throws {
    for item in value {
        try serializer.serialize_u8(value: item)
    }
}

func deserialize_array16_u8_array<D: Deserializer>(deserializer: D) throws -> [UInt8] {
    var obj : [UInt8] = []
    for _ in 0..<16 {
        obj.append(try deserializer.deserialize_u8())
    }
    return obj
}

func serialize_option_AuthenticationKey<S: Serializer>(value: AuthenticationKey?, serializer: S) throws {
    if let value = value {
        try serializer.serialize_option_tag(value: true)
        try value.serialize(serializer: serializer)
    } else {
        try serializer.serialize_option_tag(value: false)
    }
}

func deserialize_option_AuthenticationKey<D: Deserializer>(deserializer: D) throws -> AuthenticationKey? {
    let tag = try deserializer.deserialize_option_tag()
    if tag {
        return try AuthenticationKey.deserialize(deserializer: deserializer)
    } else {
        return nil
    }
}

func serialize_option_KeyRotationCapabilityResource<S: Serializer>(value: KeyRotationCapabilityResource?, serializer: S) throws {
    if let value = value {
        try serializer.serialize_option_tag(value: true)
        try value.serialize(serializer: serializer)
    } else {
        try serializer.serialize_option_tag(value: false)
    }
}

func deserialize_option_KeyRotationCapabilityResource<D: Deserializer>(deserializer: D) throws -> KeyRotationCapabilityResource? {
    let tag = try deserializer.deserialize_option_tag()
    if tag {
        return try KeyRotationCapabilityResource.deserialize(deserializer: deserializer)
    } else {
        return nil
    }
}

func serialize_option_ScriptFunction<S: Serializer>(value: ScriptFunction?, serializer: S) throws {
    if let value = value {
        try serializer.serialize_option_tag(value: true)
        try value.serialize(serializer: serializer)
    } else {
        try serializer.serialize_option_tag(value: false)
    }
}

func deserialize_option_ScriptFunction<D: Deserializer>(deserializer: D) throws -> ScriptFunction? {
    let tag = try deserializer.deserialize_option_tag()
    if tag {
        return try ScriptFunction.deserialize(deserializer: deserializer)
    } else {
        return nil
    }
}

func serialize_option_WithdrawCapabilityResource<S: Serializer>(value: WithdrawCapabilityResource?, serializer: S) throws {
    if let value = value {
        try serializer.serialize_option_tag(value: true)
        try value.serialize(serializer: serializer)
    } else {
        try serializer.serialize_option_tag(value: false)
    }
}

func deserialize_option_WithdrawCapabilityResource<D: Deserializer>(deserializer: D) throws -> WithdrawCapabilityResource? {
    let tag = try deserializer.deserialize_option_tag()
    if tag {
        return try WithdrawCapabilityResource.deserialize(deserializer: deserializer)
    } else {
        return nil
    }
}

func serialize_tuple2_AccessPath_WriteOp<S: Serializer>(value: Tuple2<AccessPath, WriteOp>, serializer: S) throws {
    try value.field0.serialize(serializer: serializer)
    try value.field1.serialize(serializer: serializer)
}

func deserialize_tuple2_AccessPath_WriteOp<D: Deserializer>(deserializer: D) throws -> Tuple2<AccessPath, WriteOp> {
    return Tuple2.init(try AccessPath.deserialize(deserializer: deserializer), try WriteOp.deserialize(deserializer: deserializer))
}

func serialize_vector_ArgumentABI<S: Serializer>(value: [ArgumentABI], serializer: S) throws {
    try serializer.serialize_len(value: value.count)
    for item in value {
        try item.serialize(serializer: serializer)
    }
}

func deserialize_vector_ArgumentABI<D: Deserializer>(deserializer: D) throws -> [ArgumentABI] {
    let length = try deserializer.deserialize_len()
    var obj : [ArgumentABI] = []
    for _ in 0..<length {
        obj.append(try ArgumentABI.deserialize(deserializer: deserializer))
    }
    return obj
}

func serialize_vector_Module<S: Serializer>(value: [Module], serializer: S) throws {
    try serializer.serialize_len(value: value.count)
    for item in value {
        try item.serialize(serializer: serializer)
    }
}

func deserialize_vector_Module<D: Deserializer>(deserializer: D) throws -> [Module] {
    let length = try deserializer.deserialize_len()
    var obj : [Module] = []
    for _ in 0..<length {
        obj.append(try Module.deserialize(deserializer: deserializer))
    }
    return obj
}

func serialize_vector_TypeArgumentABI<S: Serializer>(value: [TypeArgumentABI], serializer: S) throws {
    try serializer.serialize_len(value: value.count)
    for item in value {
        try item.serialize(serializer: serializer)
    }
}

func deserialize_vector_TypeArgumentABI<D: Deserializer>(deserializer: D) throws -> [TypeArgumentABI] {
    let length = try deserializer.deserialize_len()
    var obj : [TypeArgumentABI] = []
    for _ in 0..<length {
        obj.append(try TypeArgumentABI.deserialize(deserializer: deserializer))
    }
    return obj
}

func serialize_vector_TypeTag<S: Serializer>(value: [TypeTag], serializer: S) throws {
    try serializer.serialize_len(value: value.count)
    for item in value {
        try item.serialize(serializer: serializer)
    }
}

func deserialize_vector_TypeTag<D: Deserializer>(deserializer: D) throws -> [TypeTag] {
    let length = try deserializer.deserialize_len()
    var obj : [TypeTag] = []
    for _ in 0..<length {
        obj.append(try TypeTag.deserialize(deserializer: deserializer))
    }
    return obj
}

func serialize_vector_bytes<S: Serializer>(value: [[UInt8]], serializer: S) throws {
    try serializer.serialize_len(value: value.count)
    for item in value {
        try serializer.serialize_bytes(value: item)
    }
}

func deserialize_vector_bytes<D: Deserializer>(deserializer: D) throws -> [[UInt8]] {
    let length = try deserializer.deserialize_len()
    var obj : [[UInt8]] = []
    for _ in 0..<length {
        obj.append(try deserializer.deserialize_bytes())
    }
    return obj
}

func serialize_vector_tuple2_AccessPath_WriteOp<S: Serializer>(value: [Tuple2<AccessPath, WriteOp>], serializer: S) throws {
    try serializer.serialize_len(value: value.count)
    for item in value {
        try serialize_tuple2_AccessPath_WriteOp(value: item, serializer: serializer)
    }
}

func deserialize_vector_tuple2_AccessPath_WriteOp<D: Deserializer>(deserializer: D) throws -> [Tuple2<AccessPath, WriteOp>] {
    let length = try deserializer.deserialize_len()
    var obj : [Tuple2<AccessPath, WriteOp>] = []
    for _ in 0..<length {
        obj.append(try deserialize_tuple2_AccessPath_WriteOp(deserializer: deserializer))
    }
    return obj
}

func serialize_vector_u8<S: Serializer>(value: [UInt8], serializer: S) throws {
    try serializer.serialize_len(value: value.count)
    for item in value {
        try serializer.serialize_u8(value: item)
    }
}

func deserialize_vector_u8<D: Deserializer>(deserializer: D) throws -> [UInt8] {
    let length = try deserializer.deserialize_len()
    var obj : [UInt8] = []
    for _ in 0..<length {
        obj.append(try deserializer.deserialize_u8())
    }
    return obj
}

