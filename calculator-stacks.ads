generic
            type Item_Type is private;
        package calculator.Stacks is
            type Stack_Type is limited private;

            procedure Push (Stack : in out Stack_Type;
                            Item  : in Item_Type);
            procedure Pop  (Stack : in out Stack_Type;
                            Item  : out Item_Type);
            function Top   (Stack : Stack_Type) return Item_Type;
            function Size  (Stack : Stack_Type) return Natural;
            function Empty (Stack : Stack_Type) return Boolean;

            Stack_Overflow, Stack_Underflow : exception;

        private
            -- to be dealt with later
        end calculator-stacks.Stacks;
