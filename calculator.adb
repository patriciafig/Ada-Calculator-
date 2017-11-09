with Ada.Text_IO, Ada.Integer_Text_IO, calculator-stacks.Stacks;
        use Ada.Text_IO, Ada.Integer_Text_IO;
        procedure Calculator is
            package Operand_Stacks is new calculator-stacks.Stacks (Integer);
            package Operator_Stacks is new calculator-stacks.Stacks (Character);
            use Operand_Stacks, Operator_Stacks;

            Operand_Stack :  Operand_Stacks.Stack_Type;
            Operator_Stack : Operator_Stacks.Stack_Type;

            Operator : Character;
            Operand  : Integer;
            Line_End : Boolean;
            Got_Operand : Boolean := False;

            procedure Apply is
                Left, Right : Integer;
                Operator : Character;
            begin
                Pop (Operand_Stack, Right);
                Pop (Operand_Stack, Left);
                Pop (Operator_Stack, Operator);

                case Operator is
                    when '+' => Push (Operand_Stack, Left + Right);
                    when '-' => Push (Operand_Stack, Left - Right);
                    when '*' => Push (Operand_Stack, Left * Right);
                    when '/' => Push (Operand_Stack, Left / Right);
                    when others => raise Program_Error;
                end case;
            end Apply;

            function Prio (Operator : Character) return Natural is
            begin
                case Operator is
                    when '+' | '-' => return 1;
                    when '*' | '/' => return 2;
                    when '#' | '(' => return 0;
                    when others => raise Program_Error;
                end case;
            end Prio;

            Syntax_Error : exception;

        begin                                       -- main program
            Push (Operator_Stack, '#');
            Put ("Enter an expression: ");
            loop
                -- Get next non-space character
                loop;
                    Look_Ahead (Operator, Line_End);
                    exit when Line_End or Operator /= ' ';
                    Get (Operator);                 -- got a space, so skip it
                end loop;

                -- Exit main loop at end of line
                exit when Line_End;

                -- Process operator or operand
                if Operator in '0'..'9' then        -- it's an operand
                    if Got_Operand then             -- can't have an operand
                        Put ("Missing operator");   -- immediately after another
                        exit;
                    end if;
                    Get (Operand);                  -- read the operand
                    Push (Operand_Stack, Operand);
                    Got_Operand := True;            -- record we've got an operand
                else                                -- it's not an operand
                    Got_Operand := False;           -- so record the fact
                    exit when Operator = '.';       -- exit at end of expr.
                    Get (Operator);                 -- else read the operator
                    case Operator is                -- and apply it
                        when '+' | '-' | '*' | '/' =>
                            while Prio(Operator) <= Prio(Top(Operator_Stack)) loop
                                Apply;
                            end loop;
                            Push (Operator_Stack, Operator);

                        when '(' =>              -- stack left parenthesis
                            Push (Operator_Stack, Operator);

                        when ')' =>              -- unwind stack back to '('
                            while Prio(Top(Operator_Stack)) > Prio('(') loop
                                Apply;
                            end loop;
                            Pop (Operator_Stack, Operator);
                            if Operator /= '(' then
                                Put ("Missing left parenthesis");
                                raise Syntax_Error;
                            end if;

                        when others =>
                            Put ("Invalid operator '");
                            Put (Operator);
                            Put ("'");
                            raise Syntax_Error;
                    end case;
                end if;
            end loop;

            -- Apply remaining operators from stack
            while Prio(Top(Operator_Stack)) > Prio('#') loop
                Apply;                              -- unwind stack, apply operations
            end loop;

            -- Display result or report error
            if Top(Operator_Stack) = '#' then
                Put (Top(Operand_Stack), Width => 1);
                New_Line;
            else
                Put ("Missing right parenthesis");
                raise Syntax_Error;
            end if;
        exception
            when Syntax_Error =>
                Put_Line (" -- program terminated.");
        end Calculator;
