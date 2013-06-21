module Sprinkle
  # = Actors
  # 
  # An actor is a method of command delivery to a remote machine. Actors are the
  # layer setting between Sprinkle and the systems you and wanting to apply
  # policies to.  
  #
  # Sprinkle ships with actors for Capistrano, Vlad, localhost and pure SSH.
  module Actors
    # == Writing an actor
    #
    # All actors should inherit from Sprinkle::Actors::Actor.  Actors must provide the 
    # following methods:
    # 
    # * #install (installer, roles, options)
    # * #verify (verifier, roles, options)
    # * #servers_for_role? (roles)
    # * #sudo?
    # * #sudo_command
    #
    # Hopefully these methods are kind of fairly obvious.  They should return true
    # to indicate success and false to indicate failure.
    # The actual commands you need to execute can be retrived from 
    # +installer.install_sequence+ and +verifier.commands+.  
    class Actor
      
      # an actor must define this method so that each policy can ask the actor
      # if there are any servers with that policy's roles so the policy knows
      # whether it should execute or not
      #
      # input: a single role or array of roles
      def servers_for_role?(role)
        raise "please define servers_for_role?"
      end
      
      def install(installer, roles, options)
        raise "you must define install"
      end
      
      # an actor must define this and let the installers know if it plans
      # to try and add sudo to all of their commands or not since some
      # installers might need to handle sudo their own special way
      def sudo?
        raise "you must define sudo?"
      end
      
      # if an installer needs to call sudo this is the command the actor
      # would prefer the installers to use
      def sudo_command
        raise "you must define sudo_command"
      end
      
      def verify(verifier, roles, options)
        raise "you must define verify"
      end
      
    end
  end
end