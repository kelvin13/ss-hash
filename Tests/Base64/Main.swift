import Testing

@main 
enum Main:SyncTests
{
    static
    func run(tests:inout Tests)
    {
        tests.group("binary")
        {
            $0.test(case: Base64Test.init(name: "all",
                degenerate:
                """
                AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\
                MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\
                YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn+AgYKDhIWGh4iJiouMjY6P\
                kJGSk5SVlpeYmZqbnJ2en6ChoqOkpaanqKmqq6ytrq+wsbKztLW2t7i5uru8vb6/\
                wMHCw8TFxsfIycrLzM3Oz9DR0tPU1dbX2Nna29zd3t/g4eLj5OXm5+jp6uvs7e7v\
                8PHy8/T19vf4+fr7/P3+/w
                """,
                canonical:
                """
                AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\
                MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\
                YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn+AgYKDhIWGh4iJiouMjY6P\
                kJGSk5SVlpeYmZqbnJ2en6ChoqOkpaanqKmqq6ytrq+wsbKztLW2t7i5uru8vb6/\
                wMHCw8TFxsfIycrLzM3Oz9DR0tPU1dbX2Nna29zd3t/g4eLj5OXm5+jp6uvs7e7v\
                8PHy8/T19vf4+fr7/P3+/w==
                """,
                expected: 0x00 ... 0xff))
            
            $0.test(case: Base64Test.init(name: "reversed",
                degenerate:
                """
                //79/Pv6+fj39vX08/Lx8O/u7ezr6uno5+bl5OPi4eDf3t3c29rZ2NfW1dTT0tHQ\
                z87NzMvKycjHxsXEw8LBwL++vby7urm4t7a1tLOysbCvrq2sq6qpqKempaSjoqGg\
                n56dnJuamZiXlpWUk5KRkI+OjYyLiomIh4aFhIOCgYB/fn18e3p5eHd2dXRzcnFw\
                b25tbGtqaWhnZmVkY2JhYF9eXVxbWllYV1ZVVFNSUVBPTk1MS0pJSEdGRURDQkFA\
                Pz49PDs6OTg3NjU0MzIxMC8uLSwrKikoJyYlJCMiISAfHh0cGxoZGBcWFRQTEhEQ\
                Dw4NDAsKCQgHBgUEAwIBAA
                """,
                canonical:
                """
                //79/Pv6+fj39vX08/Lx8O/u7ezr6uno5+bl5OPi4eDf3t3c29rZ2NfW1dTT0tHQ\
                z87NzMvKycjHxsXEw8LBwL++vby7urm4t7a1tLOysbCvrq2sq6qpqKempaSjoqGg\
                n56dnJuamZiXlpWUk5KRkI+OjYyLiomIh4aFhIOCgYB/fn18e3p5eHd2dXRzcnFw\
                b25tbGtqaWhnZmVkY2JhYF9eXVxbWllYV1ZVVFNSUVBPTk1MS0pJSEdGRURDQkFA\
                Pz49PDs6OTg3NjU0MzIxMC8uLSwrKikoJyYlJCMiISAfHh0cGxoZGBcWFRQTEhEQ\
                Dw4NDAsKCQgHBgUEAwIBAA==
                """,
                expected: (0x00 ... 0xff).reversed()))
        }

        tests.group("string")
        {
            $0.test(case: Base64Test.init(name: "empty",
                canonical: "",
                expected: ""))
            
            $0.test(case: Base64Test.init(name: "single",
                degenerate: "YQ",
                canonical: "YQ==",
                expected: "a"))
            
            $0.test(case: Base64Test.init(name: "double",
                degenerate: "YWI",
                canonical: "YWI=",
                expected: "ab"))
            
            $0.test(case: Base64Test.init(name: "triple",
                canonical: "YWJj",
                expected: "abc"))
            
            $0.test(case: Base64Test.init(name: "basic",
                canonical: "TWFueSBoYW5kcyBtYWtlIGxpZ2h0IHdvcmsu",
                expected: "Many hands make light work."))
            
            $0.test(case: Base64Test.init(name: "whitespace",
                degenerate: 
                """
                T\u{0C}WFueSBoY W5kc\ryBtYWt\tlIGxpZ2
                h0IHd
                
                vcmsu 
                """,
                canonical: "TWFueSBoYW5kcyBtYWtlIGxpZ2h0IHdvcmsu",
                expected: "Many hands make light work."))
            
            $0.test(case: Base64Test.init(name: "padding-11-16",
                degenerate: "bGlnaHQgd29yay4",
                canonical: "bGlnaHQgd29yay4=",
                expected: "light work."))
            
            $0.test(case: Base64Test.init(name: "padding-10-16",
                degenerate: "bGlnaHQgd29yaw",
                canonical: "bGlnaHQgd29yaw==",
                expected: "light work"))
            
            $0.test(case: Base64Test.init(name: "padding-9-12",
                canonical: "bGlnaHQgd29y",
                expected: "light wor"))
            
            $0.test(case: Base64Test.init(name: "padding-8-12",
                degenerate: "bGlnaHQgd28",
                canonical: "bGlnaHQgd28=",
                expected: "light wo"))
            
            $0.test(case: Base64Test.init(name: "padding-7-12",
                degenerate: "bGlnaHQgdw",
                canonical: "bGlnaHQgdw==",
                expected: "light w"))
        }
    }
}
