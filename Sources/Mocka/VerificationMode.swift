public enum VerificationMode {
    case never
    case once
    case times(UInt)
    case atLeast(UInt)
    case atMost(UInt)
    case only
}
